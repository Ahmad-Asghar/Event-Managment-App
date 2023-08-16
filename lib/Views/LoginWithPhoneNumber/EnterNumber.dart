import 'package:country_picker/country_picker.dart';
import 'package:e_commerce/Widgets/ErrorDialouge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flagkit/flagkit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'OTP.dart';

class EnterNumberScreen extends StatefulWidget {
  const EnterNumberScreen({Key? key}) : super(key: key);
  static String phone = "";
  @override
  State<EnterNumberScreen> createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  final phoneNumber = TextEditingController();

  String countryCode = "92";
  String countryName = "Pakistan";
  String countryFlag = "PK";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'verify phone',
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
                      'Number',
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
                      'Please confirm your country code and\n enter your phone number :',
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
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    width: double.infinity,
                    height: 9.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: Color(0xFFE0E4F5)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            Flag.of(countryFlag),
                            SizedBox(
                              width: 4.w,
                            ),
                            Container(
                              width: 1,
                              height: 15,
                              color: Color(0xffb7b5b5),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              countryName,
                              style: TextStyle(
                                color: Color(0xFFB8BABF),
                                fontSize: 4.1.w,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    countryCode = country.phoneCode;
                                    countryFlag = country.countryCode;
                                    countryName = country.name;
                                  });
                                },
                              );
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Color(0xff8b8ec4),
                              size: 4.h,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    width: double.infinity,
                    height: 9.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.5, color: Color(0xFFE0E4F5)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "+" + countryCode,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF5A6274),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.17,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 1,
                          height: 15,
                          color: Color(0xffb7b5b5),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: Container(
                            child: TextField(
                              controller: phoneNumber,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number",
                                hintStyle: TextStyle(
                                  color: Color(0xFFB8BABF),
                                ),
                                counterText: '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .verifyPhoneNumber(
                          timeout: Duration(seconds: 120),
                          phoneNumber:
                              "+$countryCode${phoneNumber.text.toString()}",
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            EnterNumberScreen.phone = verificationId;
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        )
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTP(
                                        number:
                                            '+$countryCode${phoneNumber.text.toString()}',
                                      )));
                        }).onError((error, stackTrace) {
                          ErrorDialoge(context, error.toString());
                        });
                      },
                      color: Color(0xffffbd30),
                      child: Text(
                        "Send Code",
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
    );
  }
}

//
// Row(crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// GestureDetector(
// onTap: (){
// showCountryPicker(
// context: context,
// showPhoneCode: true,
// onSelect: (Country country) {
// setState(() {
// countryCode=country.phoneCode;
// });
// },
// );
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// border: Border.all(color: Colors.orange.shade400,width: 1.5),
// ),
// height: 5.h,
// width: 17.w,
// child: Center(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text("+"+countryCode),
// Icon(Icons.arrow_drop_down_outlined)
// ],
// ),
// ),
// ),
// ),
// SizedBox(
// width: 7.w,
// ),
// Expanded(
// child: Container(
// child: TextField(
// controller: phone,
// keyboardType: TextInputType.phone,
// maxLength: 10,
//
// decoration: InputDecoration(hintText: "Enter Phone Number",counterText: '',),
//
// ),
// ),
// ),
// ],
// ),
// // CF:26:7E:3D:4C:B1:F0:5A:23:84:59:E7:70:F1:29:23:26:79:D8:59:D9:8E:3A:75:BC:01:BE:69:6C:06:B4:6C
// MaterialButton(
// color: Colors.orange[300],
// onPressed: () async {
// await FirebaseAuth.instance.verifyPhoneNumber(
// phoneNumber: "+$countryCode${phone.text.toString()}",
// verificationCompleted: (PhoneAuthCredential credential) {},
// verificationFailed: (FirebaseAuthException e) {
// },
// codeSent: (String verificationId, int? resendToken) {
// EnterNumberScreen.phone = verificationId;
// },
// codeAutoRetrievalTimeout: (String verificationId) {},
// );
//
// Navigator.push(
// context, MaterialPageRoute(builder: (context) => OTP()));
// },
// child: Text("Send OTP"),
// ),
