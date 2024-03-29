import 'package:flutter/cupertino.dart';
import 'package:TheNomad/models/loginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    print("errorr $error");
    notifyListeners();
    return error;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    print(" userr $googleUser");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("cred $credential");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signUpNewUser(String email, String password) async {
    var err;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      err = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        err = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        err = 'The account already exists for that email.';
        print('The account already exists for that email.');
      }
    } catch (e) {
      err = e;
      print(e);
    }
    notifyListeners();
    return err;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
