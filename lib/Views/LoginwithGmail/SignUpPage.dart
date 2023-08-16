import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../Controller/Login/SignUpMethod.dart';
import '../../Widgets/ErrorDialouge.dart';
import '../../Widgets/login-textfield.dart';
import '../../Widgets/progess_timeline_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Color strengthColor = Colors.grey.shade300;
  String strengthText = "";
  double notAcceptableProgress = 0;
  double weakProgress = 0;
  double strongProgress = 0;
  double perfectProgress = 0;
  SignUpMethod signupobject = Get.put(SignUpMethod());
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            CustomAuthenticationTextField(
              onChange: (String value) {},
              textFieldController: userName,
              labelText: 'User Name',
              icon: Icons.face,
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomAuthenticationTextField(
              onChange: () {},
              textFieldController: emailController,
              labelText: 'E-mail',
              icon: Icons.alternate_email_rounded,
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomAuthenticationTextField(
              onChange: (String value) {
                if (value.length == 0) {
                  setState(() {
                    notAcceptableProgress = 0;
                    weakProgress = 0;
                    strongProgress = 0;
                    perfectProgress = 0;
                    strengthColor = Colors.grey.shade300;
                    strengthText = "";
                  });
                }
                if (value.length >= 1 && value.length <= 2) {
                  setState(() {
                    notAcceptableProgress = 1;
                    weakProgress = 0;
                    strongProgress = 0;
                    perfectProgress = 0;
                    strengthColor = Colors.red;
                    strengthText = "Not Acceptable";
                  });
                }
                if (value.length >= 3 && value.length <= 5) {
                  setState(() {
                    weakProgress = 1;
                    notAcceptableProgress = 1;
                    strongProgress = 0;
                    perfectProgress = 0;
                    strengthColor = Colors.yellow;
                    strengthText = "Weak";
                  });
                }
                if (value.length == 6) {
                  setState(() {
                    weakProgress = 1;
                    notAcceptableProgress = 1;
                    strongProgress = 1;
                    perfectProgress = 0;
                    strengthColor = Colors.blueAccent;
                    strengthText = "Acceptable";
                  });
                }
                if (value.length > 7 && value.length <= 10) {
                  setState(() {
                    perfectProgress = 1;
                    strengthColor = Colors.green;
                    strengthText = "Perfect";
                  });
                }
              },
              textFieldController: passwordController,
              labelText: 'Password',
              icon: Icons.key,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 1.5.h,
                      backgroundColor: perfectProgress == 1
                          ? Colors.green
                          : Colors.grey[300],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 2.3.h,
                      )),
                  SizedBox(width: 3.w),
                  Text(
                    'Password must include least 6 characters',
                    style: TextStyle(color: Color(0xFF0F0B03), fontSize: 3.1.w),
                  ),
                ],
              ),
            ),
            notAcceptableProgress == 1
                ? SizedBox(
                    height: 2.h,
                  )
                : Container(),
            notAcceptableProgress == 1
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      children: [
                        ProgressTimeline(
                          progress: notAcceptableProgress,
                          color: strengthColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ProgressTimeline(
                          progress: weakProgress,
                          color: strengthColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ProgressTimeline(
                          progress: strongProgress,
                          color: strengthColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        ProgressTimeline(
                          progress: perfectProgress,
                          color: strengthColor,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          strengthText,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 4.h,
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
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        userName.text.isNotEmpty) {
                      signupobject.SignUp(
                          context,
                          emailController.text.toString(),
                          passwordController.text.toString(),
                          userName.text.toString());
                    } else {
                      ErrorDialoge(
                          context, "Email,Password and Name couldn't be empty");
                    }
                  },
                  color: Color(0xffffbd30),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// child: Scaffold(
//   bottomNavigationBar: BottomAppBar(
//       color: Colors.white     ,
//       elevation: 0,
//       child:  Row(
//
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Already have an account?",
//             style: TextStyle(
//                 fontSize: 2.3.h,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.yellow[800]
//             ),
//           ),
//           TextButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//           }, child: Text("Login",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo
//             ),))
//         ],
//       )
//   ),
//
//   body: Container(
//     color: Colors.white,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RichText(
//               text: TextSpan(
//                 children: <TextSpan>[
//                   TextSpan(text: "Sign Up " ,style: TextStyle(fontSize:4.h,fontWeight: FontWeight.bold,color: Colors.indigo)),
//                   TextSpan(text: " Here!" ,style: TextStyle(fontSize:4.h,fontWeight: FontWeight.bold,color: Colors.orange[600])),
//                 ],
//               ),
//             ),
//             SizedBox(width: 6.w,),
//             Image(image: AssetImage("images/ecommerce.png"),
//               height: 8.h,
//             ),
//           ],
//         ),
//         Form(
//             key: _formkey,
//             child: Column(
//               children: [
//                 Textfield(email: emailcontroller, icon: Icons.alternate_email, hintext: "Email", mesege: 'Enter Email',),
//                 Textfield(email: passwordcontroller, icon: Icons.key, hintext: "Password", mesege: 'Enter Password',),
//                 Textfield(email: confirmpasswordcontroller, icon: Icons.key, hintext: "Confirm Password", mesege: 'Enter Password',)
//               ],
//             )),
//         SizedBox(height: 3.h,),
//         MaterialButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           onPressed: (){
//             if(_formkey.currentState!.validate()){
//               print("Validation Working");
//               signupobject.SignUp(context,emailcontroller.text.toString(),passwordcontroller.text.toString());
//
//
//             }
//
//           },
//           color: Colors.orange[600],
//           height: 7.h,
//           minWidth: 30.w,
//           child: Text("Sign Up",
//             style: TextStyle(
//                 fontSize: 2.3.h,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white
//             ),
//           ),),
//
//
//       ],
//     ),
//   ),
// ),
