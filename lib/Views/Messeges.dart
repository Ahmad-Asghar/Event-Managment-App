import 'package:e_commerce/Views/nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Localization/code/local_keys.g.dart';

class Messeges extends StatefulWidget {
  const Messeges({Key? key}) : super(key: key);

  @override
  State<Messeges> createState() => _MessegesState();
}

class _MessegesState extends State<Messeges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[500],
        title: Text(LocaleKeys.message).tr(),
      ),

      body: Container(
        child: Center(
          child: Text(LocaleKeys.hello).tr(),
        ),
      ),

    );
  }
}