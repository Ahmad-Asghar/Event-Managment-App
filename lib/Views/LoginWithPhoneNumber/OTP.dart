import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/LoginwithGmail/LoginPage.dart';
import 'package:e_commerce/Views/LoginwithGmail/SignUpPage.dart';
import 'package:e_commerce/Widgets/ErrorDialouge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Models/UserModel.dart';
import '../nav_bar.dart';
import 'EnterNumber.dart';

class OTP extends StatefulWidget {
  final String number;
  OTP({Key? key, required this.number}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController otp = TextEditingController();
  final otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'verification',
                        style: TextStyle(
                          fontSize: 4.7.h,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Code',
                        style: TextStyle(
                          fontSize: 2.5.h,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffbd30),
                            borderRadius: BorderRadius.circular(20)),
                        height: 0.6.h,
                        width: 14.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Verification code was sent to',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0F0B03),
                          fontSize: 4.4.w,
                          fontWeight: FontWeight.w400,
                          height: 1.88,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    width: 60.w,
                    height: 7.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF4F5FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 4.2.w),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            )),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  OTPTextField(
                    onChanged: (String value) {
                      setState(() {
                        otp.text = value;
                        print(otp.text.toString());
                      });
                    },
                    otpFieldStyle:
                        OtpFieldStyle(focusBorderColor: Colors.orange),
                    controller: otpController,
                    spaceBetween: 10,
                    length: 6,
                    width: 100.w,
                    fieldWidth: 12.w,
                    style: TextStyle(fontSize: 17),
                    fieldStyle: FieldStyle.box,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 7.h,
                        minWidth: 50.w,
                        onPressed: () {},
                        color: Colors.grey[200],
                        child: Text(
                          "Resend Code",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 7.h,
                        minWidth: 50.w,
                        // onPressed: () {
                        //  late PhoneAuthCredential credential;
                        //
                        //      credential = PhoneAuthProvider.credential(
                        //       verificationId: EnterNumberScreen.phone,
                        //       smsCode: otp.text.toString());
                        //  User? user = authResult.user;
                        //  if (user != null) {
                        //    String uid = user.uid; // This is the user's UID
                        //    print("User ID: $uid");
                        //
                        //    // You can now use the UID for further operations or to store user-specific data
                        //  } else {
                        //    print("User is null");
                        //  }
                        //     FirebaseAuth.instance
                        //         .signInWithCredential(credential).then((value){
                        //           print("Logging IN Method ----"+credential.signInMethod);
                        //           print("Logging IN providerId ----"+credential.providerId);
                        //           print("Logging IN token ----${credential.token}");
                        //           print("Logging IN accessToken ----${credential.accessToken}");
                        //     }).onError((error, stackTrace){
                        //       print(error.toString());
                        //     });
                        //
                        // },

                        onPressed: () {
                          late PhoneAuthCredential credential;
                          credential = PhoneAuthProvider.credential(
                            verificationId: EnterNumberScreen.phone,
                            smsCode: otp.text.toString(),
                          );

                          FirebaseAuth.instance
                              .signInWithCredential(credential)
                              .then((authResult) {
                            User? user = authResult.user;
                            if (user != null) {
                              UserModel newmodel = UserModel(
                                uid: user.uid,
                                email: user.phoneNumber,
                                fullName: "UN-NAMED",
                                profilepic:"",
                              );
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(user.uid)
                                  .set(newmodel.toMap());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                        userModel: newmodel,
                                        firebaseuser: user,
                                        screenNO: 0,
                                      )));
                              print('User signed in Phone: ${user.phoneNumber}');
                            } else {
                              print('Sign in failed');
                            }
                          }).catchError((error) {
                            ErrorDialoge(context, error.toString());
                          });
                        },

                        color: Color(0xffffbd30),
                        child: Text(
                          "Verify",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//           OTPTextField(
//
//             controller: otpController,
//             spaceBetween: 10,
//             length: 6,
//             width: 100.w,
//             fieldWidth: 10.w,
//             style: TextStyle(
//                 fontSize: 17
//             ),
//             textFieldAlignment: MainAxisAlignment.spaceAround,
//             fieldStyle: FieldStyle.underline,
//             onCompleted: (pin) {
//               print("Completed: " + pin);
//             },
//           ),
//           SizedBox(height: 5.h,),
//
//           MaterialButton(
//             color: Colors.orange[300],
//             onPressed: () async{
//
//            try{
// PhoneAuthCredential credential =PhoneAuthProvider.credential(
// verificationId: EnterNumberScreen.phone,
// smsCode: otpController.toString());
//
// FirebaseAuth.instance.signInWithCredential(credential);
// Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
// }
// catch(e){
//      print("ERRor.........................") ;
// }
//            },
//
//
//             child: Text("Verify Phone Number"),
//
//           ),
