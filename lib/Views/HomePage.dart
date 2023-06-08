

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Controller/Join_Event.dart';
import 'package:e_commerce/Models/UserModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Localization/code/local_keys.g.dart';
import 'SignUpPage.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const HomePage(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
  print( widget.userModel.uid.toString());
    super.initState();
  }
String eventID="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EMS",
                      style:
                          TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications_active_outlined)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.dehaze_rounded)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    Text(
                      "What's Going on today",
                      style:
                          TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Events").orderBy('eventCreatedTime',descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something wrong!"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            snapshot.data!.docs.forEach((DocumentSnapshot document) {
                               eventID=document.id.toString();
                              print(eventID);
                            });

                            String event_creator_Image = snapshot
                                .data!.docs[index]['senderModel'][1]
                                .toString();
                            String event_creator_Name = snapshot
                                .data!.docs[index]['senderModel'][2]
                                .toString();
                            String event_IMage = snapshot
                                .data!.docs[index]["eventImage"]
                                .toString();
                            String event_date = snapshot
                                .data!.docs[index]["dateTime"]
                                .toString();
                            String event_Name = snapshot
                                .data!.docs[index]["eventName"]
                                .toString();
                            String max_entries = snapshot
                                .data!.docs[index]["maxEntries"]
                                .toString();
                            String location = snapshot
                                .data!.docs[index]["location"]
                                .toString();
                            String price =
                                snapshot.data!.docs[index]["price"].toString();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 15,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 48.h,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 3.5.h,
                                              backgroundImage: NetworkImage(
                                                  event_creator_Image),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              event_creator_Name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.h),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        child: Container(
                                          height: 39.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 1.h),
                                                child: Material(
                                                  color: Colors.orange[100],
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  elevation: 10,

                                                  child: Container(

                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5),
                                                      child: CachedNetworkImage(


                                                        imageUrl: event_IMage,
                                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    height: 25.h,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.person,
                                                              color:
                                                                  Colors.orange,
                                                              size: 2.5.h,
                                                            ),
                                                            Text(
                                                              max_entries,
                                                              style: TextStyle(
                                                                  fontSize: 2.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      height: 3.5.h,
                                                      width: 15.w,
                                                    ),
                                                    Text(
                                                      event_Name,
                                                      style: TextStyle(
                                                          fontSize: 3.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Dated: " + event_date,
                                                      style: TextStyle(
                                                          fontSize: 1.5.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          Text(
                                                            location,
                                                            style: TextStyle(
                                                                fontSize: 2.h,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .monetization_on_outlined,
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          Text(
                                                            price,
                                                            style: TextStyle(
                                                                fontSize: 2.h,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      color: Colors.orange[400],
                                                      height: 5.h,
                                                      onPressed: () {
                                                       // joinEvent(widget.userModel,eventID );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text("Join Event")
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
