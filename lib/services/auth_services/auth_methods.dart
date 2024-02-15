
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices{
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _prefsUserIdKey = 'user_id';
  //* signing in via
  Future<UserCredential> signingWithEmailPassword(String email, password)async{
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection("Users123").doc(userCredential.user!.uid).set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        });

        if (userCredential.user != null) {
        await _saveUserIdInPrefs(userCredential.user!.uid);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //! sign up via
  Future<UserCredential> signUpWIthEmailandPassword(String email, password)async{
    try {
      UserCredential userCreate =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCreate.user != null) {
        //! Store user details in Firestore database 
        await _storeUserDetails(userCreate.user!.uid, email,);

        await getUserDetailsFromFirestore(userCreate.user!.uid);

        //! Save user id in local storage of the phone
        await _saveUserIdInPrefs(userCreate.user!.uid);

      }


    //? save user in a seperate doc
      _firestore.collection("Users123").doc(userCreate.user!.uid).set(
        {
          "uid": userCreate.user!.uid,
          "email": email,
        });
      return userCreate;
    } catch (e) {
      throw Exception(e);
    }
  }

  //? get the current user
  User? getCurrentUser(){
   return _auth.currentUser;
  }

   Future<bool> isUserLoggedIn() async {
    return _auth.currentUser != null;
  }



  //* sign out via
  Future<void> signOut()async{
    return await _auth.signOut();
  }


  
  Future<void> logout() async {
    await _auth.signOut();
    await _clearUserIdInPrefs();
  }

  Future<void> _storeUserDetails(String userId, String email) async {
    await _firestore.collection('users1234').doc(userId).set({
      'email': email,
    });
  }

   Future<Map<String, dynamic>?> getUserDetailsFromFirestore(String userId) async {
  final doc = await _firestore.collection('users1234').doc(userId).get();
  return doc.data();
}



  Future<void> _saveUserIdInPrefs(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefsUserIdKey, userId);
  }

  Future<String?> getUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsUserIdKey);
  }

  Future<void> _clearUserIdInPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_prefsUserIdKey);
  }
}