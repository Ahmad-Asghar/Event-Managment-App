import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Models/UserModel.dart';
import 'nav_bar.dart';

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
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData && snapshot.data!.exists) {
                      UserModel user = UserModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);


                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 10.h,
                            backgroundImage: NetworkImage(user.profilepic.toString()),
                          ),
                          Text(user.fullName.toString()),
                          Text(user.email.toString()),
                          Text(user.uid.toString()),
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
    );
  }
}
