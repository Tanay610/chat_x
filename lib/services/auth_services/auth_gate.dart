

import 'package:chat_x/services/auth_services/login_or_sign.dart';
import 'package:chat_x/view/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
      //* when user is logged in
      if (snapshot.hasData) {
        return const HomePage();
      //* user is not logged in  
      } else {
        return const LgoinOrRegister();
      }
    });
  }
}


