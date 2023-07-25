import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/successDialouge.dart';



Future<void> leaveEvent(String userWantToLeave, String documentID, BuildContext context) async {
  DocumentReference docRef = FirebaseFirestore.instance.collection('Events').doc(documentID);
  DocumentSnapshot docSnapshot = await docRef.get();
  Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
  List<dynamic> joinedList = data['joined'];

  if (!joinedList.contains(userWantToLeave)) {
    showSuccessDialoge(context, "Not Joined this Event");
    return;
  } else {
    docRef.update({
      'joined': FieldValue.arrayRemove([userWantToLeave]),
    }).then((value) {
      print('Document updated successfully.');
      showSuccessDialoge(context, "Successfully Left");
    }).catchError((error) {
      print('Failed to update document: $error');
    });
  }
}