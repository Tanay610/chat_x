import 'package:chat_x/controllers/home_controller.dart';
import 'package:chat_x/controllers/signup_controller.dart';
import 'package:chat_x/services/auth_services/auth_methods.dart';
import 'package:chat_x/services/chat_services/chat_service.dart';
import 'package:chat_x/view/components/page_build_x.dart';
import 'package:chat_x/view/components/userTile_x.dart';
import 'package:chat_x/view/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatServices _chatServices = ChatServices();
  final _authServices = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          title: const Text(
            "Home",
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                    var controller = Get.put(HomeController());
                        return AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Are you sure to log out",
                              style: TextStyle(
                                  color:Colors.black),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("NO")),
                            TextButton(
                                onPressed: () {
                                  controller.signOut();
                                  Get.offAllNamed("/login");
                                },
                                child: const Text("YES"))
                          ],
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      child: ListTile(
                    title: Text(
                      'Log out',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.logout,
                      color: Colors.purple.shade400,
                      size: 30,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
        body: _buildUserList(),
      ),
    );
  }

  //* build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatServices.getUserSTream(),
        builder: (context, snapshot) {
          //* error if present
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //* loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          //* return list view
          return ListView(
            children: snapshot.data!
                .map((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //* display all users except current user
   return Obx(() {
    final user = Get.put(HomeController()).firebaseUser.value;
    // print(user);
      if (userData["email"] != user) {
      return UserTile(
        onTiletap: () {
          Navigator.of(context).push(pageRouteBuilder(ChatPage(
              receiverEmail: userData['email'], receiverId: userData['uid'])));
          },
        text: userData['email'],
      );
    } else {
      return const SizedBox();
    }
    });
  }
}
