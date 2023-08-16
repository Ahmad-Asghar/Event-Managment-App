import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../TextRecognition.dart';
import 'EventDetails.dart';

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
    print(widget.userModel.uid.toString());
    super.initState();
  }

  List<String> EventIds = [];

  void replaceIfExist(String newText) {
    int index = EventIds.indexOf(newText);
    if (index != -1) {
      EventIds[index] = newText;
      print('Text replaced successfully.');
    } else {
      EventIds.add(newText);
      print('Text added to the list.');
    }
  }

  String eventID = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                            icon: const Icon(Icons.notifications_active_outlined)),
                        IconButton(
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPickerScreen()));
                            },
                            icon: const Icon(Icons.videocam_rounded)),
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
                    .collection("Events")
                    .orderBy('eventCreatedTime', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something wrong!"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset("images/loading.json"),
                    );
                  }
                  if (snapshot.data?.docs.isEmpty ?? true) {
                    return const Expanded(
                        child: Center(child: Text("No Events to Show Yet!")));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            snapshot.data!.docs
                                .forEach((DocumentSnapshot document) {
                              eventID = document.id.toString();
                              replaceIfExist(eventID.toString());

                              print(eventID);
                              print(EventIds.length.toString());
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
                                                event_creator_Image,
                                              ),
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
                                                      BorderRadius.circular(
                                                          5),
                                                  elevation: 10,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    height: 25.h,
                                                    width: double.infinity,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                      child:
                                                          CachedNetworkImage(
                                                        imageUrl: event_IMage,
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                          50),
                                                              child: Lottie.asset(
                                                                  "images/loading.json")),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
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
                                                      decoration:
                                                          BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey,
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
                                                              color: Colors
                                                                  .orange,
                                                              size: 2.5.h,
                                                            ),
                                                            Text(
                                                              max_entries,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      2.h,
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
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                    Text(
                                                      "Dated: " + event_date,
                                                      style: TextStyle(
                                                          fontSize: 1.5.h,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
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
                                                          const Icon(
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
                                                          // Icon(
                                                          //   Icons
                                                          //       .monetization_on_outlined,
                                                          //   color:
                                                          //       Colors.orange,
                                                          // ),
                                                          // Text(
                                                          //   price,
                                                          //   style: TextStyle(
                                                          //       fontSize: 2.h,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .bold),
                                                          // ),
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
                                                      color:
                                                          Colors.orange[400],
                                                      height: 5.h,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EventDetails(
                                                                          eventId:
                                                                              EventIds[index].toString(),
                                                                          userModel:
                                                                              widget.userModel,
                                                                          firebaseuser:
                                                                              widget.firebaseuser,
                                                                        )));
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text("View Event")
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
                  }
                }),
          ],
        ),
      ),
    );
  }
}
