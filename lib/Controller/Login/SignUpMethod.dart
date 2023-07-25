import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/UserModel.dart';
import '../../Views/LoginwithGmail/CompleteProfile.dart';
import '../../Widgets/DialougeBox.dart';
import '../../Widgets/ErrorDialouge.dart';
import '../../Widgets/Snackbar.dart';
class SignUpMethod extends GetxController {
  Snackbar snack = Get.put(Snackbar());

  SignUp(BuildContext context,  String emailcontroller, String passwordcontroller) async {
    showWaitingDialouge(context);
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller, password: passwordcontroller);

      String uid = credential.user!.uid;
      UserModel newmodel = UserModel(
        uid: uid,
        email: emailcontroller,
        fullName: "",
        profilepic: "",
      );
      FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set(newmodel.toMap());
      Navigator.pop(context);
      snack.snackBar("Confirmation", "Successfully Signed In", Colors.blue,
          Colors.white, "images/checked.png");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteProfile(
          userModel: newmodel, firebaseuser: credential!.user!)));

    } on FirebaseAuthException catch (exception) {
      Navigator.pop(context);
      ErrorDialoge(context,exception.code);
      // snack.snackBar("Error", exception.code.toString(), Colors.red.shade400,
      //     Colors.white, "images/close.png");
    }
  }
}
