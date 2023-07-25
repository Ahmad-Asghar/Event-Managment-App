import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/successDialouge.dart';


Future<void> joinEvent(String userWantToJoin ,String documentID,BuildContext context) async {

  DocumentReference docRef = FirebaseFirestore.instance.collection('Events').doc(documentID);
  DocumentSnapshot docSnapshot = await docRef.get();
  Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
  List<dynamic> joinedList = data['joined'];
  if (joinedList.contains(userWantToJoin)) {
    showSuccessDialoge(context,"Already Joined this Event");
    return;
  }
  else{
    docRef.update({
      'joined': FieldValue.arrayUnion([userWantToJoin]),
    }).then((value) {
      print('Document updated successfully.');
      showSuccessDialoge(context,"Successfully Joined");
    }).catchError((error) {
      print('Failed to update document: $error');
    });
  }

}