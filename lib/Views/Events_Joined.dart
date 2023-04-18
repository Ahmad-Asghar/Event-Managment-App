import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Localization/code/local_keys.g.dart';

class Joined_Events extends StatefulWidget {
  const Joined_Events({Key? key}) : super(key: key);

  @override
  State<Joined_Events> createState() => _Joined_EventsState();
}

class _Joined_EventsState extends State<Joined_Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(LocaleKeys.event_joined).tr(),
        ),
      ),
    );
  }
}
