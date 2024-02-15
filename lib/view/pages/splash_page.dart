import 'package:chat_x/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                child: SvgPicture.asset("assets/images/chat-round-unread-svgrepo-com.svg",
                color: Colors.white,
                height: 130,
                width: 130,
                )),
            ),
          const SizedBox(
            child: Text("Chat X",
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
            ),
          )

          ],
        ),
      ),
    );
  }
}