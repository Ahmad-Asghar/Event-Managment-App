import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Models/UserModel.dart';
import 'package:e_commerce/Views/Events_Joined.dart';
import 'package:e_commerce/Views/Events_created.dart';
import 'package:e_commerce/Views/LoginwithGmail/LoginPage.dart';
import 'package:e_commerce/Views/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Localization/code/local_keys.g.dart';
import 'LoginwithGmail/SignUpPage.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Profile({Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.orange[300],
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(context: context, builder: (BuildContext context){

                                      return AlertDialog(
                                      title: Text("Select Language"),
                                        actions: [
                                          ListTile(title: Text("English"),onTap: (){context.setLocale(Locale("en"));Navigator.pop(context);},),
                                          ListTile(title: Text("Arabic"),onTap: (){context.setLocale(Locale("ar"));Navigator.pop(context);},),
                                          ListTile(title: Text("Urdu"),onTap: (){context.setLocale(Locale("ur"));Navigator.pop(context);},),

                                        ],
                                      );
                                    }
                                    );
                                  },
                                  icon: Icon(Icons.language),
                                  color: Colors.white,
                                ),
                                Text(LocaleKeys.profile,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 3.h),).tr(),
                                IconButton(
                                  onPressed: () {
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                    });
                                  },
                                  icon: Icon(Icons.logout),
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.blue[300],
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: double.infinity,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: double.infinity,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(15),
                              elevation: 9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.userModel.fullName.toString(),
                                      style: TextStyle(
                                          fontSize: 3.h,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      widget.userModel.email.toString(),
                                      style: TextStyle(
                                        fontSize: 2.h,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.5.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6.3.h,
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                widget.userModel.profilepic.toString()),
                            radius: 6.h,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Text(LocaleKeys.hello).tr(),
              Text(
                  LocaleKeys.user_info,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 2.5.h),
              ).tr(),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage("images/create.png"),),
                  ),),
                  Tab(child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image(image: AssetImage("images/join.png"),),
                  ),),

                ],
              ),
              Expanded(
                child: TabBarView(
                controller: _tabController,
                children: [
                  Created_Events(userModel: widget.userModel, firebaseuser: widget.firebaseuser,),
                  Joined_Events(userModel: widget.userModel, firebaseuser: widget.firebaseuser,),

                ],
              ),)

            ],
          ),
        ),
      ),
    );
  }
}
