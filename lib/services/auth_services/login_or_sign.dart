
import 'package:chat_x/view/pages/login_page.dart';
import 'package:chat_x/view/pages/singup_page.dart';
import 'package:flutter/material.dart';

class LgoinOrRegister extends StatefulWidget {
  const LgoinOrRegister({super.key});

  @override
  State<LgoinOrRegister> createState() => _LgoinOrRegisterState();
}

class _LgoinOrRegisterState extends State<LgoinOrRegister> {
  //* initially show login page
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onRegisterTap: togglePages,);
    } else {
      return SignupPage(onLogintap: togglePages,);
    }
  }
}