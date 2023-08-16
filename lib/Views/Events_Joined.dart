import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Controller/Event_controllers/leave_Event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Models/UserModel.dart';
import '../Models/Event.dart';
class Joined_Events extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Joined_Events(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<Joined_Events> createState() => _Joined_EventsState();
}

class _Joined_EventsState extends State<Joined_Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Events").snapshots(),
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

                  final data = snapshot.data!.docs;
                  final filteredUEvent = data
                      .where(
                          (doc) => doc['joined'].contains(widget.userModel.uid))
                      .map((doc) =>
                          Event.fromMap(doc.data() as Map<String, dynamic>))
                      .toList();
                  print(filteredUEvent.length.toString());
                  if (filteredUEvent.length == 0) {
                    return Expanded(
                        child: Center(child: Text("No Events to Show Yet!")));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredUEvent.length,
                        itemBuilder: (BuildContext context, int index) {
                          final joinedEvent = filteredUEvent[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            child: Dismissible(
                              key: Key(joinedEvent.eventId.toString()),
                              direction: DismissDirection.horizontal,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (direction) {
                                leaveEvent(widget.userModel.uid.toString(),
                                    joinedEvent.eventId.toString(), context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 15.h,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    SizedBox(width: 3.w),
                                    Material(
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 10,
                                      child: Container(
                                        height: 13.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: joinedEvent.eventImage
                                                .toString(),
                                            placeholder: (context, url) => Center(
                                                child:
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    child: Lottie.asset("images/loading.json"))),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 25.w,
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Container(
                                      width: 40.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            joinedEvent.eventName.toString(),
                                            style: TextStyle(
                                                fontSize: 2.4.h,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Created By : " +
                                                joinedEvent.senderModel![2]
                                                    .toString(),
                                            style: TextStyle(fontSize: 2.h),
                                          ),
                                          Text(
                                            joinedEvent.price.toString(),
                                            style: TextStyle(
                                                fontSize: 2.4.h,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Location : " +
                                                joinedEvent.location.toString(),
                                            style: TextStyle(fontSize: 2.h),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Icon(
                                      Icons.chevron_left_sharp,
                                      color: Colors.red,
                                      size: 6.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
