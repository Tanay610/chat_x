import 'package:chat_x/services/auth_services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  AuthServices auth = AuthServices();

  Future<UserCredential> login(String email, String password)async{
    try {
      final UserCredential user = await auth.signingWithEmailPassword(email, password);

      if (user.credential!=null) {
        Get.snackbar("You are now logged in", "Enjoy");
      } else {
        Get.snackbar("Login failed", "Please try again");
      }
      return user;
    } catch (e) {
      throw Exception(e.toString());
      
    }
  }


  User? currentUser(){
    return auth.getCurrentUser();
  }


}