import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> signUp(String email, String password) async {
    try {
      var signedUp = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

        _firestore.collection("Users123").doc(signedUp.user!.uid).set(
        {
          "uid": signedUp.user!.uid,
          "email": email,
        });    
      Get.offAllNamed('/home');
      Get.snackbar('Sign Up Successful', 'Welcome!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }



  Future<void> login(String email, String password) async {
    try {
      var signedIn = await _auth.signInWithEmailAndPassword(email: email, password: password);

      _firestore.collection("Users123").doc(signedIn.user!.uid).set(
        {
          "uid": signedIn.user!.uid,
          "email": email,
        });
      Get.offAllNamed('/home');
      Get.snackbar('Login Successful', 'Welcome back!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
    Get.snackbar('Logged Out', 'See you soon!', snackPosition: SnackPosition.BOTTOM);
  }
}
