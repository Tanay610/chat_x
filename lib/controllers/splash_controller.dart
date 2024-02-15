import 'dart:async';

import 'package:chat_x/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final authcontroller = Get.find<AuthController>();
  

  @override
  void onInit() {
    super.onInit();
     checkUserLoggedIn();

    // Timer(Duration(seconds: 4), () { 
    //    Get.offNamed("/auth");
    // });
    
  }


  Future<void> checkUserLoggedIn() async {
    final user = authcontroller.user.value;
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


}