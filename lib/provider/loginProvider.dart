import 'package:flutter/cupertino.dart';
import 'package:TheNomad/models/loginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  // Check the values and authenticate it and return the token

  void signInUser(LoginModel user) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      print(
        "credentials $credential",
      );
    } on FirebaseAuthException catch (e) {
      print("firebase err $e");
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("error $e");
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
