import 'dart:async';

import 'package:chat_x/routes/x_pages.dart';
import 'package:chat_x/services/auth_services/auth_gate.dart';
import 'package:chat_x/services/auth_services/auth_methods.dart';
import 'package:chat_x/services/auth_services/login_or_sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  AuthServices auth = AuthServices();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn();

    // Timer(Duration(seconds: 4), () { 
    //    Get.offNamed("/auth");
    // });
    
  }


  Future<void> checkUserLoggedIn() async {
    final user = _auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed("/home");
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Get.offAllNamed("/login");
       });
      
    }
  }


  void checkAuthStatus() async {
    bool isLoggedIn = await auth.isUserLoggedIn();
    if (isLoggedIn) {
      Get.offNamed(AppPages.homepage,);
    } else {
      Get.offNamed(AppPages.login);
    }
  }
}