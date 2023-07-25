import 'package:e_commerce/Views/LoginwithGmail/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'EnterNumber.dart';

class OTP extends StatefulWidget {
  OTP({Key? key}) : super(key: key);


  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final otpController=OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Verify OTP"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 5.h,),

              OTPTextField(
                controller: otpController,
                spaceBetween: 10,
                length: 6,
                width: 100.w,
                fieldWidth: 10.w,
                style: TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
              SizedBox(height: 5.h,),

              MaterialButton(
                color: Colors.orange[300],
                onPressed: () async{

               try{
    PhoneAuthCredential credential =PhoneAuthProvider.credential(
    verificationId: EnterNumberScreen.phone,
    smsCode: otpController.toString());

    FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
    }
    catch(e){
         print("ERRor.........................") ;
    }
               },


                child: Text("Verify Phone Number"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
