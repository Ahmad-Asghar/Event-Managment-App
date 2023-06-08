import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> ErrorDialoge(BuildContext context,String messege) async{

  showDialog(context: context,barrierDismissible: false, builder: (BuildContext context){

    return AlertDialog(

      actions: [
        Center(
          child: Column(
            children: [
              Icon(Icons.error_outline,color: Colors.orange[500],size: 10.h,),
              SizedBox(height: 2.h,),
              Text(messege),
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Try Again")),
            ],
          ),

        )
      ],
    );
  });

}