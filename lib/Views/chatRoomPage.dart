import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/Messeges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Models/MessegeModel.dart';
import '../Models/UserModel.dart';
import '../Models/chatRoomModel.dart';
import '../Widgets/Snackbar.dart';
import 'nav_bar.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  final UserModel targetuser;
  final ChatRoomModel chatroom;

  const ChatRoomPage(
      {Key? key,
      required this.userModel,
      required this.firebaseuser,
      required this.chatroom,
      required this.targetuser})
      : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messegecontroller = TextEditingController();
  Snackbar snack = Get.put(Snackbar());
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void sendMessege() async {
    String msg = messegecontroller.text.toString();
    messegecontroller.clear();
    if (msg != null) {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      MessegeModel newMessege = MessegeModel(
        messegeid: id,
        sender: widget.userModel.uid,
        createdOn: DateTime.now().toString(),
        text: msg,
        seen: false,
      );
      FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(widget.chatroom.chatRoomId)
          .collection("Messeges")
          .doc(newMessege.messegeid)
          .set(newMessege.toMap());

      widget.chatroom.lastmessege = msg;

      FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(widget.chatroom.chatRoomId)
          .set(widget.chatroom.toMap());
      print("Messege sent");
    }
    _scrollToBottom();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Get.to(Home(
                    userModel: widget.userModel,
                    firebaseuser: widget.firebaseuser));
              },
              icon: Icon(Icons.arrow_back_ios_sharp)),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.targetuser.profilepic.toString()),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                widget.targetuser.fullName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("ChatRooms")
                          .doc(widget.chatroom.chatRoomId)
                          .collection("Messeges")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot datasnapshot =
                                snapshot.data as QuerySnapshot;

                            return ListView.builder(
                                controller: _scrollController,
                                itemCount: datasnapshot.docs.length,
                                itemBuilder: (context, index) {
                                  MessegeModel currentmsg =
                                      MessegeModel.fromMap(
                                          datasnapshot.docs[index].data()
                                              as Map<String, dynamic>);

                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: .5.h),
                                    child: Row(
                                      mainAxisAlignment: (currentmsg.sender ==
                                              widget.userModel.uid)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 70.w,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: currentmsg.sender ==
                                                        widget.userModel.uid
                                                    ? Colors.grey[500]
                                                    : Colors.orange[200],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(1.5.h),
                                                child: Text(
                                                  currentmsg.text.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Container(
                                  child: Text(
                                      "Something went Wrong!\n Check Your Internet Connnection!")),
                            );
                          } else {
                            return Center(
                              child: Text("Say Hi to your friend"),
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
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 0.5.h),
                          child: TextField(
                            controller: messegecontroller,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter message"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.5.w,
                    ),
                    InkWell(
                      onTap: () {
                        sendMessege();
                      },
                      child: CircleAvatar(
                        radius: 3.5.h,
                        backgroundColor: Colors.orange[400],
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
