import 'package:chat_x/controllers/signup_controller.dart';
import 'package:chat_x/view/components/button_x.dart';
import 'package:chat_x/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/textFiled_x.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key, this.onLogintap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final void Function()? onLogintap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/chat-round-unread-svgrepo-com.svg",
            height: 80,
            width: 80,
            color: Colors.white,
          ),

          const SizedBox(
            height: 50,
          ),
          Text(
            "Let's create an account for you.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          //* email textfield
          TextFieldWidget(
              hintName: 'Email',
              obsecure: false,
              fieldController: _emailController),
          const SizedBox(
            height: 18,
          ),
          //* password textfield
          TextFieldWidget(
              hintName: "Password",
              obsecure: true,
              fieldController: _passwordController),
          const SizedBox(
            height: 18,
          ),

          TextFieldWidget(
              hintName: "Confirm Password",
              obsecure: true,
              fieldController: _confirmController),
          const SizedBox(
            height: 28,
          ),

          ButtonX(
              buttonName: "Sign Up",
              onButtonTap: () {
                var controller = Get.find<SignupController>();
                if (_passwordController.text == _confirmController.text) {
                  
                  controller.signup(
                      _emailController.text, _passwordController.text);
                  Get.offAllNamed("/home");
                }

              }),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Text(
                  "Login now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade500),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
