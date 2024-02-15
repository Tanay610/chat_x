import 'package:chat_x/services/auth_services/auth_gate.dart';
import 'package:chat_x/services/auth_services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthServices authServices = AuthServices();
    // Rx<User?> currentUser = Rx<User?>(EmailAuthCredential);


   Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> checkAuthStatus() async {
     _auth.authStateChanges().listen((user) {
      if (user != null) {
        //? User is logged in
        Get.offAllNamed("/home");
      } else {
        //? User is not logged in
        Get.offAllNamed("/login");
      }
    });
  }

    Future<void> signOut()async{
    return _auth.signOut();
  }

  

  // Method to get the current user
  // User? getCurrentUser() {
  //   print(currentUser.value);
  //   return currentUser.value;
  // }


}