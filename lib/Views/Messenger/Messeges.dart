import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controller/FirebaseHelper.dart';
import '../../Localization/code/local_keys.g.dart';
import '../../Models/UserModel.dart';
import '../../Models/chatRoomModel.dart';
import 'chatRoomPage.dart';


class Messeges extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Messeges(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<Messeges> createState() => _MessegesState();
}

class _MessegesState extends State<Messeges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.2,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: AppBar(
            flexibleSpace: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Text(
                            "Recent Chats",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: Text(
                            "Requests",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: 20.h,
              width: 10.w,
            ),
            actions: [
              Icon(Icons.search),
              SizedBox(
                width: 3.w,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 3.3.h,
                child: CircleAvatar(
                  radius: 3.h,
                  backgroundImage: CachedNetworkImageProvider(
                      widget.userModel.profilepic.toString()),
                ),
              ),
              SizedBox(
                width: 3.4.w,
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.orange[300],
            leading: Container(),
            automaticallyImplyLeading: false,
            title: Text(
              LocaleKeys.message,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.h),
            ).tr(),
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favourite Chats",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 2.5.h),
                    ),
                    Icon(Icons.star)
                  ],
                ),
              ),
              // Container(
              //   height: 14.h,
              //   child: Expanded(
              //     child: StreamBuilder(
              //         stream: FirebaseFirestore.instance
              //             .collection("Users")
              //             .snapshots(),
              //         builder: (BuildContext context,
              //             AsyncSnapshot<QuerySnapshot> snapshot) {
              //           return ListView.builder(
              //
              //               scrollDirection: Axis.horizontal,
              //               itemCount: snapshot.data!.docs.length,
              //               itemBuilder: (BuildContext context, int index) {
              //                 return Padding(
              //                   padding: EdgeInsets.symmetric(horizontal: 2.w),
              //                   child: Column(
              //                     children: [
              //                       CircleAvatar(
              //                         radius: 5.1.h,
              //                         backgroundColor: Colors.green,
              //                         child: CircleAvatar(
              //                           radius: 4.8.h,
              //                           backgroundColor: Colors.white,
              //                           child: CircleAvatar(
              //                             backgroundImage: NetworkImage(snapshot
              //                                 .data!.docs[index]['profilepic']
              //                                 .toString()),
              //                             radius: 4.6.h,
              //                           ),
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         height: 1.h,
              //                       ),
              //                       Text(
              //                         snapshot.data!.docs[index]['fullName']
              //                             .toString(),
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               });
              //         }),
              //   ),
              // ),


//              StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("Users").snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       return Expanded(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (BuildContext context, int index) {
//
//                             return  Padding(
//                               padding:  EdgeInsets.symmetric(vertical: 1.h),
//                               child: ListTile(
// leading: CircleAvatar(
//   backgroundImage: NetworkImage(snapshot
//       .data!.docs[index]['profilepic']
//       .toString()),
// radius: 4.6.h,
// ),
//                                 trailing: Text("3m ago"),
//                                 subtitle: Text("OK..see you soon!"),
//                                 title: Text(snapshot
//                                     .data!.docs[index]['fullName']
//                                     .toString(),style: TextStyle(fontWeight: FontWeight.bold),),
//                               ),
//                             );
//                             }
//                             ),
//                       );
//                     }),


              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("ChatRooms")
                      .where("users", arrayContains: widget.userModel.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot chatroomsnapshot =
                        snapshot.data as QuerySnapshot;
                        return Expanded(
                          child: ListView.builder(
                              itemCount: chatroomsnapshot.docs.length,
                              itemBuilder: (context, index) {
                                ChatRoomModel chatrummodel = ChatRoomModel.fromMap(
                                    chatroomsnapshot.docs[index].data()
                                    as Map<String, dynamic>);

                                Map<String, dynamic> participants =
                                chatrummodel.participants!;

                                List<String> participantskeys =
                                participants.keys.toList();
                                participantskeys.remove(widget.userModel.uid);
                                return FutureBuilder(
                                    future: FirebaseHelper.getUserMOdelById(
                                        participantskeys[0]),
                                    builder: (context, userData) {
                                      if (userData.connectionState ==
                                          ConnectionState.done) {
                                        if (userData.data != null) {
                                          UserModel targetuser =
                                          userData.data as UserModel;
                                          return ListTile(
                                            onTap: () {
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoomPage(
                                                 userModel: widget.userModel,
                                                 firebaseuser: widget.firebaseuser,
                                                 chatroom: chatrummodel,
                                                 targetuser: targetuser)));
                                            },
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  targetuser.profilepic.toString()),
                                            ),
                                            title: Text(
                                                targetuser.fullName.toString()),
                                            subtitle: Text(chatrummodel.lastmessege
                                                .toString()),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        return Container();
                                      }
                                    });
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Something went Wrong!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("No Chats!"),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
