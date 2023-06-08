import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/UserModel.dart';


Future<void> joinEvent(UserModel userModel,String documentID) async {

  DocumentReference docRef = FirebaseFirestore.instance.collection('Events').doc(documentID);


  docRef.update({
    'joined': FieldValue.arrayUnion([userModel.uid.toString()]),
  }).then((value) {
    print('Document updated successfully.');
  }).catchError((error) {
    print('Failed to update document: $error');
  });



}