import 'package:e_commerce/Models/UserModel.dart';
import 'package:get/get.dart';

class Event extends GetxController {
  String? eventCreatedTime;
  String? eventImage;
  String? eventName;
  String? location;
  String? dateTime;
  String? maxEntries;
  String? tags;
  String? frequency;
  String? startTime;
  String? endTime;
  String? price;
  String? privacy;
  String? eventStatus;
  List<String>? sender;
  List<String>? joined;
  List<String>? senderModel;


  Event(
      {
        this.eventCreatedTime,
        this.eventImage,
        this.eventName,
      this.maxEntries,
      this.dateTime,
      this.location,
      this.endTime,
      this.frequency,
      this.joined,
      this.price,
      this.sender,
      this.startTime,
      this.tags,
      this.privacy,
        this.eventStatus,
        this.senderModel
      });

  Event.fromMap(Map<String, dynamic> map) {
    eventCreatedTime=map['eventCreatedTime'];
    senderModel=map['senderModel'];
    eventImage=map['eventImage'];
    privacy=map['privacy'];
    eventStatus=map['eventStatus'];
    eventName = map['eventName'];
    maxEntries = map['maxEntries'];
    dateTime = map['dateTime'];
    location = map['location'];
    endTime = map['endTime'];
    frequency = map['frequency'];
    joined = map['joined'];
    price = map['price'];
    sender = map['sender'];
    startTime = map['startTime'];
    tags = map['tags'];

  }
  Map<String, dynamic> toMap() {
    return {
      'eventCreatedTime':eventCreatedTime,
      'senderModel':senderModel,
      'eventImage':eventImage,
      'eventStatus':eventStatus,
      'privacy':privacy,
      'eventName': eventName,
      'maxEntries': maxEntries,
      'dateTime': dateTime,
      'location': location,
      'endTime': endTime,
      'frequency': frequency,
      'joined': joined,
      'price': price,
      'sender': sender,
      'startTime': startTime,
      'tags': tags,
    };
  }
}
