import 'package:chat_x/controllers/login_controller.dart';
import 'package:chat_x/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/button_x.dart';
import '../components/textFiled_x.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onRegisterTap;
  LoginPage({super.key, this.onRegisterTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.offNamed("/home");
            },
            child: SvgPicture.asset(
              "assets/images/chat-round-unread-svgrepo-com.svg",
              height: 120,
              width: 120,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Welcome back, to the best chat app.",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFieldWidget(
              hintName: 'Email',
              obsecure: false,
              fieldController: _emailController),
          const SizedBox(
            height: 18,
          ),
          TextFieldWidget(
              hintName: "Password",
              obsecure: true,
              fieldController: _passwordController),
          const SizedBox(
            height: 27,
          ),
          ButtonX(
            buttonName: "Login",
            onButtonTap: () {
              var controller = Get.put(LoginController());
              try {
                controller.login(
                    _emailController.text, _passwordController.text);
              } catch (e) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(e.toString()),
                      );
                    });
              }
              Get.offAllNamed("/home");
            },
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(fontSize: 14, color: Colors.purple.shade500),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed("/signup");
                },
                child: Text(
                  "Register now",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
