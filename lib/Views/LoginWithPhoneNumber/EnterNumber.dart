import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'OTP.dart';

class EnterNumberScreen extends StatefulWidget {
  const EnterNumberScreen({Key? key}) : super(key: key);

  static String phone="";
  @override
  State<EnterNumberScreen> createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {

  final phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Phone Number"),
        ),
        body: Container(
          child: Column(

            children: [

SizedBox(height: 2.h,),
              Padding(
                padding:  EdgeInsets.all(4.w),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number"
                  ),

                ),
              ),
          // CF:26:7E:3D:4C:B1:F0:5A:23:84:59:E7:70:F1:29:23:26:79:D8:59:D9:8E:3A:75:BC:01:BE:69:6C:06:B4:6C
              MaterialButton(
                color: Colors.orange[300],
                onPressed: () async{
await  FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: phone.text.toString(),
    verificationCompleted: (PhoneAuthCredential credential){},
    verificationFailed: (FirebaseAuthException e){},
    codeSent: (String verificationId,int? resendToken){
      EnterNumberScreen.phone=verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId){},);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OTP()));
                },

              child: Text("Send OTP"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
