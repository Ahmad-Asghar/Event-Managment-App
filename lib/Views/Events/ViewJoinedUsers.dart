import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Models/UserModel.dart';

class JoinedUsers {
  void showUsers(BuildContext context, List<String>? usersList, String creator,
      UserModel userModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Text('No data available');
              }

              final data = snapshot.data!.docs;
              final filteredUsers = data
                  .where((doc) => usersList!.contains(doc.id))
                  .map((doc) => UserModel.fromMap(doc.data()))
                  .toList();

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      height: 0.6.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      height: 2.4.h,
                    ),
                    Text(
                      "People Joined This Event",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 2.6.h),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];

                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                              child: Container(
                                height: 9.h,
                                width: double.infinity,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  CircleAvatar(
                                minRadius:3.5.h,
                                      backgroundImage:
                                          NetworkImage(user.profilepic.toString(),

                                          ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(user.fullName.toString(),style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 2.5.h
                                        ),),
                                        Text(userModel.uid==creator?"You're Creator of this Event":"Joined this event..Not the Creator",style: TextStyle(
                                          color: Colors.green
                                        ),),

                                      ],
                                    ),
    userModel.uid==creator?IconButton(onPressed: (){
        print("Deleted");
      }, icon: Icon(Icons.delete,color: Colors.red,)):Container(),

                                  ],
                                ),

                              ),
                            );

                            // return ListTile(
                            //   // trailing: userModel.uid==creator?IconButton(onPressed: (){
                            //   //   print("Deleted");
                            //   // }, icon: Icon(Icons.delete,color: Colors.red,)):Container(),
                            //   leading: CircleAvatar(
                            //     backgroundImage:
                            //         NetworkImage(user.profilepic.toString()),
                            //   ),
                            //   title: Text(user.fullName.toString()),
                            // );
                          }),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Go Back",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              );
            },
          );
        });
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    //       stream: FirebaseFirestore.instance
    //           .collection("Users")
    //           .snapshots(),
    //       builder: (BuildContext context,
    //           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    //         if (snapshot.hasError) {
    //           return Text('Error: ${snapshot.error}');
    //         }
    //
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //
    //         if (!snapshot.hasData || snapshot.data == null) {
    //           return Text('No data available');
    //         }
    //
    //         final data = snapshot.data!.docs;
    //         final filteredUsers = data.where((doc) => usersList!.contains(doc.id))
    //             .map((doc) => UserModel.fromMap(doc.data()))
    //             .toList();
    //
    //
    //         return AlertDialog(
    //           actions: [
    //             Container(
    //               color: Colors.white,
    //               height: MediaQuery.of(context).size.height * 0.8,
    //               width: MediaQuery.of(context).size.width,
    //               child: Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 2.w),
    //                 child: Column(
    //                   children: [
    //                     SizedBox(height: 2.h,),
    //                     Text("People Joining This Event",style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 2.6.h
    //                     ),),
    //                     SizedBox(height: 2.h,),
    //                    Expanded(
    //                      child: ListView.builder(
    //                        shrinkWrap: true,
    //                          itemCount: filteredUsers.length,
    //                          itemBuilder: (context, index) {
    //                            final user = filteredUsers[index];
    //                            return ListTile(
    //                              subtitle: Text(userModel.uid==creator?"You can Remove the user":"No you can't"),
    //                              leading: CircleAvatar(
    //                                backgroundImage: NetworkImage(
    //                                  user.profilepic.toString()
    //                                ),
    //
    //                              ),
    //                              title:  Text(user.fullName.toString()),
    //                            );
    //                          }
    //                          ),
    //                    ),
    //                     TextButton(onPressed: (){
    //                       Navigator.pop(context);
    //                     }, child: Text("Go Back"))
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
