import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Localization/code/local_keys.g.dart';

class Created_Events extends StatefulWidget {
  const Created_Events({Key? key}) : super(key: key);

  @override
  State<Created_Events> createState() => _Created_EventsState();
}

class _Created_EventsState extends State<Created_Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(LocaleKeys.event_created).tr(),
        ),
      ),
    );
  }
}
