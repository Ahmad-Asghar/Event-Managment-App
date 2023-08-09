import 'dart:io';
import 'package:e_commerce/Views/Events/HomePage.dart';
import 'package:e_commerce/Views/Profile.dart';
import 'package:e_commerce/Views/Events/add_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Localization/code/local_keys.g.dart';
import '../Models/UserModel.dart';
import 'Feeds.dart';
import 'Messenger/Messeges.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  final int screenNO;
  const Home({
    super.key,
    required this.userModel,
    required this.firebaseuser,
    required this.screenNO,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int index;
  late List<StatefulWidget> screen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.screenNO;
    screen = [
      HomePage(
        userModel: widget.userModel,
        firebaseuser: widget.firebaseuser,
      ),
      Feeds(
        userModel: widget.userModel,
        firebaseUser: widget.firebaseuser,
      ),
      Add_Event(
        userModel: widget.userModel,
        firebaseuser: widget.firebaseuser,
      ),
      Messeges(
        userModel: widget.userModel,
        firebaseuser: widget.firebaseuser,
      ),
      Profile(
        userModel: widget.userModel,
        firebaseuser: widget.firebaseuser,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool check = askConfirmation(context) as bool;
        return check;
      },
      child: SafeArea(
        child: Scaffold(
            body: screen[index],
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Container(
                color: Colors.white,
                height: 10.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                index = 0;
                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: index == 0
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                                child: ImageIcon(
                                    size: 15,
                                    const AssetImage(
                                      "images/home.png",
                                    ),
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.orange[500]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.home,
                              style: TextStyle(
                                color: index == 0
                                    ? Colors.orange[500]
                                    : const Color(0xff686868),
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                index = 1;

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: index == 1
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                                child: ImageIcon(
                                    size: 15,
                                    const AssetImage("images/category.png"),
                                    color: index == 1
                                        ? Colors.white
                                        : Colors.orange[500]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.feeds,
                              style: TextStyle(
                                color: index == 1
                                    ? Colors.orange[500]
                                    : const Color(0xff686868),
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                index = 2;

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: index == 2
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                                child: ImageIcon(
                                    size: 70,
                                    AssetImage(
                                      "images/plus.png",
                                    ),
                                    color: index == 2
                                        ? Colors.white
                                        : Colors.orange[500]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.add_new,
                              style: TextStyle(
                                color: index == 2
                                    ? Colors.orange[500]
                                    : const Color(0xff686868),
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                index = 3;

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: index == 3
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                                child: ImageIcon(
                                    size: 15,
                                    const AssetImage("images/contact.png"),
                                    color: index == 3
                                        ? Colors.white
                                        : Colors.orange[500]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.message,
                              style: TextStyle(
                                color: index == 3
                                    ? Colors.orange[500]
                                    : const Color(0xff686868),
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                index = 4;

                                setState(() {});
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: index == 4
                                    ? Colors.orange[300]
                                    : Colors.grey[100],
                                child: ImageIcon(
                                    size: 15,
                                    const AssetImage("images/profile.png"),
                                    color: index == 4
                                        ? Colors.white
                                        : Colors.orange[500]),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.profile,
                              style: TextStyle(
                                color: index == 4
                                    ? Colors.orange[500]
                                    : const Color(0xff686868),
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future askConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert!"),
          content: Text("You want to exit..??"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
