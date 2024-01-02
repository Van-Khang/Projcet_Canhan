import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:projcet_canhan/constants/constants.dart';



class FirebaseAuthHelper{
  static FirebaseAuthHelper instance = FirebaseAuthHelper(); 
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
    String email, String password, BuildContext context) async{
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch(error) {
      showMessage(error.code.toString());
      return false;
    }
  }

   Future<bool> signUp(
    String email, String password, BuildContext context) async{
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch(error) {
      showMessage(error.code.toString());
      return false;
    }
  }
}