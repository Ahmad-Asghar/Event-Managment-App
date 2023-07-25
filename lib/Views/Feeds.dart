import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Localization/code/local_keys.g.dart';
import '../Models/UserModel.dart';
import '../Models/chatRoomModel.dart';
import '../Widgets/Event_data_textfield.dart';
import 'Messenger/chatRoomPage.dart';
import 'checkProfile.dart';

class Feeds extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Feeds({Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  TextEditingController searchedController = TextEditingController();

  late List<DocumentSnapshot> filteredData;
  late List<DocumentSnapshot> secondFilteration = [];

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatroom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("ChatRooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      print("Already Have a Chat Room");

      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatroom = existingChatRoom;
    } else {
      print("Create a Chat Room");
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomId: id,
        lastmessege: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        users: [widget.userModel.uid.toString(), targetUser.uid.toString()],
        datetime: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());
      chatroom = newChatRoom;
      print("Chat Room Created!");
    }
    return chatroom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.orange[300],
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              LocaleKeys.feeds,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.h),
            ).tr(),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Event_Textfield(
              text: searchedController,
              icon: Icons.search,
              hintext: "Search User",
              onpressed: () {},
              readOnly: false,
              onChanged: (value) {
                setState(() {
                  secondFilteration = filteredData
                      .where((doc) => doc['fullName']
                          .toString()
                          .toLowerCase()
                          .contains(
                              searchedController.text.toLowerCase().trim()))
                      .toList();
                });
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong!"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                filteredData = snapshot.data!.docs
                    .where(
                        (doc) => widget.userModel.uid != doc['uid'].toString())
                    .toList();
                if (searchedController.text.isEmpty) {
                  print(filteredData.length.toString());
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.4.w, vertical: 0.7.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              onTap: () async {
                                // Map<String, dynamic> userMap =
                                //     filteredData[index].data()
                                //         as Map<String, dynamic>;
                                // UserModel searchedUser =
                                //     UserModel.fromMap(userMap);
                                // ChatRoomModel? chatroomModel =
                                //     await getChatRoomModel(searchedUser);
                                // if (chatroomModel != null) {
                                //   Navigator.pop(context);
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => ChatRoomPage(
                                //           userModel: widget.userModel,
                                //           firebaseuser: widget.firebaseuser,
                                //           targetuser: searchedUser,
                                //           chatroom: chatroomModel,
                                //         ),
                                //       ));
                                // }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckProfile(
                                          userModel: widget.userModel,
                                              firebaseuser: widget.firebaseuser,
                                              userId: filteredData[index]['uid']
                                                  .toString(),
                                            )));
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  filteredData[index]['profilepic'].toString(),
                                ),
                              ),
                              title: Text(
                                filteredData[index]['fullName'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                filteredData[index]['email'].toString(),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: secondFilteration.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.4.w, vertical: 0.7.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckProfile(
                                            userModel: widget.userModel,
                                            firebaseuser: widget.firebaseuser,
                                                userId: filteredData[index]
                                                        ['uid']
                                                    .toString(),
                                              )));
                                  // Map<String, dynamic> userMap =
                                  //     secondFilteration[index].data()
                                  //         as Map<String, dynamic>;
                                  // UserModel searchedUser =
                                  //     UserModel.fromMap(userMap);
                                  // ChatRoomModel? chatroomModel =
                                  //     await getChatRoomModel(searchedUser);
                                  // if (chatroomModel != null) {
                                  //   Navigator.pop(context);
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => ChatRoomPage(
                                  //           userModel: widget.userModel,
                                  //           firebaseuser: widget.firebaseuser,
                                  //           targetuser: searchedUser,
                                  //           chatroom: chatroomModel,
                                  //         ),
                                  //       ));
                                  // }
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    secondFilteration[index]['profilepic']
                                        .toString(),
                                  ),
                                ),
                                title: Text(
                                  secondFilteration[index]['fullName']
                                      .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  secondFilteration[index]['email'].toString(),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_circle_right_outlined),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
