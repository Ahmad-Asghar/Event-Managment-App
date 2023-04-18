import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showSuccessDialoge(BuildContext context) async{

  showDialog(context: context, builder: (BuildContext context){

    return AlertDialog(

      actions: [
        Center(
          child: Column(
            children: [
              Icon(Icons.check_circle,color: Colors.orange[500],size: 10.h,),
              SizedBox(height: 2.h,),
              Text("Successfully Done"),
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("OK")),
            ],
          ),

        )
      ],
    );
  });

}