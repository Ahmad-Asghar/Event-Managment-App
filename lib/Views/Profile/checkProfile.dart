import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controller/chatroom_check.dart';
import '../../Models/UserModel.dart';
import '../../Models/chatRoomModel.dart';
import '../Messenger/chatRoomPage.dart';
import '../nav_bar.dart';

class CheckProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  final String userId;

  const CheckProfile(
      {Key? key,
      required this.userId,
      required this.userModel,
      required this.firebaseuser})
      : super(key: key);

  @override
  State<CheckProfile> createState() => _CheckProfileState();
}

class _CheckProfileState extends State<CheckProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    userModel: widget.userModel,
                                    firebaseuser: widget.firebaseuser,
                                    screenNO: 1,
                                  )));
                    },
                    icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.userId)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData && snapshot.data!.exists) {
                        UserModel user = UserModel.fromMap(
                            snapshot.data!.data() as Map<String, dynamic>);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(35),
                              child: Container(

                                height: MediaQuery.sizeOf(context).height * 0.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.orange[100],
                                  borderRadius: BorderRadius.circular(35),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(30),
                                    child: user.profilepic!=""?Container(
                                      height: MediaQuery.sizeOf(context).height * 0.4,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              user.profilepic.toString(),
                                            ),
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                    ):Container(
                                      height: MediaQuery.sizeOf(context).height * 0.4,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "images/minion.jpg",
                                            ),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              user.fullName.toString(),
                              style: GoogleFonts.lilitaOne(
                                  fontSize: 4.5.h, color: Colors.orange[400]),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              user.email.toString(),
                              style: GoogleFonts.lilitaOne(
                                fontSize: 2.5.h,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                      Text(
                        "Connect with this ${user.fullName} for mutual benefits. Their involvement can greatly enhance your event management endeavors. Don't miss out!",
                      style: GoogleFonts.signika(
                      fontSize: 2.3.h,
                        color: Colors.grey
                      ),
                      ),

                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    height: 7.h,
                                    color: Colors.orange[400],
                                    onPressed: () async {

                                      ChatRoomModel? chatroomModel =
                                          await getChatRoomModel(user,widget.userModel.uid.toString());
                                      if (chatroomModel != null) {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoomPage(
                                                userModel: widget.userModel,
                                                firebaseuser: widget.firebaseuser,
                                                targetuser: user,
                                                chatroom: chatroomModel,
                                              ),
                                            ));
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.waving_hand,color: Colors.white,),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text("Say Hi",style: GoogleFonts.lilitaOne(
                                          fontSize: 2.5.h,
                                          color: Colors.white
                                        ),),
                                      ],
                                    ),
                                ),
                                ),
                              ],
                            ),


                          ],
                        );
                      }
                      return Text('User not found.');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
