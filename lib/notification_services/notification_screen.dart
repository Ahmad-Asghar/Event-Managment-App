import 'package:e_commerce/notification_services/notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationServices notificationServices=NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    notificationServices.requestNotificationPermission();
    notificationServices.onFirebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print("FCM TOKEN-----"+value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child: Scaffold(
          appBar: AppBar(
            centerTitle: true
            ,
            title: Text("Notifications"),
          ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    ));
  }
}
