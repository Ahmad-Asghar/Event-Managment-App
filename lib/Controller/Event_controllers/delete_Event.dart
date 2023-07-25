import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../Views/nav_bar.dart';
import '../../Widgets/ErrorDialouge.dart';
import '../../Widgets/successDialouge.dart';

void deletePicture(String picturePath) {
  final Reference storageRef = FirebaseStorage.instance.ref("Event Pictures/$picturePath");

  // Delete the picture
  storageRef.delete().then((_) {
    print('Picture deleted successfully.');
  }).catchError((error) {
    print('Failed to delete picture: $error');
  });
}
Future<void> deleteEvent(BuildContext context,String eventId,UserModel userModel,User firebaseuser,String picturePath) async {
  try {

     FirebaseFirestore.instance
        .collection('Events')
        .doc(eventId)
        .delete();
     deletePicture(picturePath);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(
      userModel: userModel,
      firebaseuser: firebaseuser, screenNO: 0,)));
    showSuccessDialoge(context,"Successfully Deleted");

  } catch (error) {
    ErrorDialoge(context,error.toString());
  }
}
