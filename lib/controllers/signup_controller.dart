
import 'package:chat_x/services/auth_services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController{
  AuthServices auth = AuthServices();

  Future<UserCredential> signup(String email, String password)async{
    try {
      
    final UserCredential user = await auth.signUpWIthEmailandPassword(email, password);
    if (user.credential!=null) {
      Get.snackbar("You are singed up", "Enjoy");
    } else {
      Get.snackbar("Sign up failed", "Please try again");
      
    }
    return user;
    } catch (e) {
      throw Exception(e);
    }

  } 



  

}