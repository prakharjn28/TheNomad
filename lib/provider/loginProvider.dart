import 'package:flutter/cupertino.dart';
import 'package:TheNomad/models/loginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  // Check the values and authenticate it and return the token

  signInUser(LoginModel user) async {
    var error;
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      error = "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        error = "Wrong password provided for that user.";
      }
    } catch (e) {
      error = e;
    }
    notifyListeners();
    return error;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
