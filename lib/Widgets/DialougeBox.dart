import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showWaitingDialouge(BuildContext context)async {

  showDialog(context: context,barrierDismissible: false, builder: (BuildContext context){

    return AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 3.h,),
                Text("Wait until the process completes"),
              ],
            ),
          ),
        ),
      ],
    );
  });

}
