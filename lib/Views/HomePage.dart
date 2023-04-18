import 'package:e_commerce/Models/UserModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Localization/code/local_keys.g.dart';
import 'SignUpPage.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const HomePage({Key? key,
    required this.userModel, required this.firebaseuser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.orange[600],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(LocaleKeys.home).tr(),
          ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.userModel.uid.toString()),
              Text(widget.userModel.email.toString(),style: TextStyle(
                  fontSize: 17,

              ),),
              Text(widget.userModel.fullName.toString(),style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
              Text(LocaleKeys.hello).tr(),


            ],
          ),

        ),
      ),
    );
  }
}
