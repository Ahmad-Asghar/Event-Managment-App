import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/nav_bar.dart';
import 'package:e_commerce/Widgets/DialougeBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../Controller/SignUpMethod.dart';
import '../Models/UserModel.dart';
import '../Views/HomePage.dart';
import '../Widgets/Snackbar.dart';
import '../Widgets/TextField.dart';
class LoginMethod extends GetxController {

  Snackbar snack = Get.put(Snackbar());

  LoginMethod1( BuildContext context, String emailcontroller,String passwordcontroller) async {
print("HI");
showWaitingDialouge(context);
    UserCredential? credentials;
    try{

      credentials = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: emailcontroller, password: passwordcontroller);
      String uid=credentials.user!.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection("Users").doc(uid).get();
      UserModel userModel=UserModel.fromMap(userData.data() as Map<String ,dynamic>);

      snack.snackBar("Congratulations", 'Successfully Loged In',Colors.blue,Colors.white,"images/checked.png");
     // Get.to(Home());
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(userModel: userModel, firebaseuser: credentials!.user!)));
      //Get.to(Home(userModel: userModel, firebaseuser: credentials.user!));

    }
    on FirebaseAuthException catch(exception){
      snack.snackBar("Error", exception.code.toString(),Colors.red.shade400,Colors.white,"images/close.png");
    }


  }



}



