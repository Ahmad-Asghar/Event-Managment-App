import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/DialougeBox.dart';
import '../../Widgets/successDialouge.dart';


Future<void> uploadVideo(String videoLink ,String documentID,BuildContext context) async {

  DocumentReference docRef = FirebaseFirestore.instance.collection('Events').doc(documentID);
    docRef.update({
      'eventVideos': FieldValue.arrayUnion([videoLink]),
    }).then((value) {
      print('Video Uploaded successfully.');
      Navigator.pop(context);
      showSuccessDialoge(context,"Successfully Uploaded");
    }).catchError((error) {
      print('Failed to Uploaded Videos: $error');
    });


}