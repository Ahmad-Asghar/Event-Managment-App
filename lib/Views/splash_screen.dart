import 'dart:async';
import 'package:e_commerce/Controller/FirebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'LoginwithGmail/LoginPage.dart';
import 'nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUsers() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      var fetchedUserModel =
          await FirebaseHelper.getUserMOdelById(currentUser.uid);
      if (fetchedUserModel != null) {
        Timer(const Duration(seconds: 4), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userModel: fetchedUserModel,
                        firebaseuser: currentUser,
                        screenNO: 0,
                      )));
          // Get.to(Home(userModel: fetchedUserModel, firebaseuser: currentuser));
        });
      }
    }
    else {
      Timer(

          Duration(seconds: 4), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }

  initState() {
  //  _googleSignIn.signOut();

    checkUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("images/ecommerce.png"),
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
