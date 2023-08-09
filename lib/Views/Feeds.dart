import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Localization/code/local_keys.g.dart';
import '../Models/UserModel.dart';
import '../Widgets/Event_data_textfield.dart';
import 'checkProfile.dart';

class Feeds extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const Feeds({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  TextEditingController searchedController = TextEditingController();

  late List<DocumentSnapshot> filteredData;
  late List<DocumentSnapshot> secondFilteration = [];


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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckProfile(
                                          userModel: widget.userModel,
                                              firebaseuser: widget.firebaseUser,
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
                                            firebaseuser: widget.firebaseUser,
                                                userId: filteredData[index]
                                                        ['uid']
                                                    .toString(),
                                              )));
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
