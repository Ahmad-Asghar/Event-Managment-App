
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Event.dart';
import '../Widgets/DialougeBox.dart';
import '../Widgets/Snackbar.dart';
import '../Widgets/successDialouge.dart';

class Upload_Event extends GetxController{

   Event event = new Event();
Snackbar snack=Snackbar();
   Future <void> upload(
       BuildContext context,
       List<String> senderModel,
       File imageFile,
       String eventName,
       String location,
       String dateTime,
       String maxEntries,
       String tags,
       String frequency,
       String startTime,
       String endTime,
       String price,
       String privacy,
       String eventStatus,
       List<String> sender,
       List<String> joined,
       String creationTime,

       )async {
      showWaitingDialouge(context);
String id=DateTime.now().microsecondsSinceEpoch.toString();
UploadTask uploadTask=FirebaseStorage.instance.ref("Event Pictures").child(id).putFile(imageFile);
TaskSnapshot snapshot=await uploadTask;
String eventImage= await snapshot.ref.getDownloadURL();

Event model=  Event(
   eventCreatedTime: creationTime,
   senderModel:senderModel,
   eventImage: eventImage,
   eventName: eventName,
   location: location,
   dateTime: dateTime,
   maxEntries: maxEntries,
   tags: tags,
   frequency: frequency,
   startTime: startTime,
   endTime: endTime,
   price: price,
    privacy: privacy,
   eventStatus: eventStatus,
   sender: sender,
   joined: joined,

);

FirebaseFirestore.instance
    .collection("Events")
    .doc(id)
    .set(model.toMap());
print("Added");
Navigator.pop(context);
      showSuccessDialoge(context);
// snack.snackBar("Confirmation", "Event Added Successfully", Colors.blue,
//     Colors.white, "images/checked.png");

   }


}