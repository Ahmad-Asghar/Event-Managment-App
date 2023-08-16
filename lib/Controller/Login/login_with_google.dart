import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Models/UserModel.dart';
import '../../Views/nav_bar.dart';

class LoginWithGoogle {
  static Future<void> handleSignIn(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        authResult.credential?.token.toString();
        final User? user = authResult.user;

        if (user != null) {
          UserModel newmodel = UserModel(
            uid: user.uid,
            email: user.email,
            fullName: user.displayName,
            profilepic: user.photoURL,
          );
          FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .set(newmodel.toMap());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userModel: newmodel,
                        firebaseuser: user,
                        screenNO: 0,
                      )));
          print('User signed in email: ${user.email}');
          print('User signed in password: ${user.phoneNumber}');
          print('User signed in: ${user.displayName}');
          print(
              'User signed in picture: ${authResult.credential?.token.toString()}');
        } else {
          print('Sign in failed');
        }
      }
    } catch (error) {
      print('Error during Google sign in: $error');
    }
  }
}
