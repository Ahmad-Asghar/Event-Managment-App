import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../Controller/Login/LoginMethod.dart';
import '../../Controller/Login/login_with_google.dart';
import '../../Widgets/ErrorDialouge.dart';
import '../../Widgets/custom_outline_button.dart';
import '../../Widgets/login-textfield.dart';
import '../LoginWithPhoneNumber/EnterNumber.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  bool status = false;
  int currentPage = 0;
  final pageController = PageController();
  LoginMethod login = Get.put(LoginMethod());

  final _formKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          "images/ecommerce.png",
                        ),
                        height: 3.5.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Event Management",
                        style: GoogleFonts.lilitaOne(
                          fontSize: 2.5.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff4f5fa),
                          borderRadius: BorderRadius.circular(30)),
                      height: 10.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 2.w),
                              child: MaterialButton(
                                elevation: currentPage == 0 ? 2 : 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 7.h,
                                onPressed: () {
                                  setState(() {
                                    pageController.animateToPage(
                                      0,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.bounceOut,
                                    );
                                  });
                                },
                                color: currentPage == 0
                                    ? Color(0xffffbd30)
                                    : Color(0xfff4f5fa),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.w, left: 2.w),
                              child: MaterialButton(
                                elevation: currentPage == 1 ? 2 : 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 7.h,
                                onPressed: () {
                                  setState(() {
                                    pageController.animateToPage(
                                      1,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.bounceOut,
                                    );
                                  });
                                },
                                color: currentPage == 1
                                    ? Color(0xffffbd30)
                                    : Color(0xfff4f5fa),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Expanded(
                    child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (int page) {
                          setState(() {
                            currentPage = page;
                          });
                        },
                        controller: pageController,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          if (currentPage == 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    CustomAuthenticationTextField(
                                      textFieldController: loginEmailController,
                                      labelText: 'E-mail',
                                      icon: Icons.alternate_email_rounded,
                                      onChange: () {},
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    CustomAuthenticationTextField(
                                      textFieldController:
                                          loginPasswordController,
                                      labelText: 'Password',
                                      icon: Icons.key,
                                      onChange: () {},
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Remember me",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 2.2.h,
                                              color: Colors.black),
                                        ),
                                        FlutterSwitch(
                                          activeColor: Color(0xffffbd30),
                                          width: 13.w,
                                          height: 3.5.h,
                                          value: status,
                                          borderRadius: 30.0,
                                          onToggle: (val) {
                                            setState(() {
                                              status = val;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "or login with",
                                      style: TextStyle(
                                          fontSize: 2.h, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomOutlineButton(
                                          image: 'images/google.png',
                                          onTap: () {
                                            LoginWithGoogle.handleSignIn(
                                                context);
                                          },
                                        ),
                                        CustomOutlineButton(
                                          image: 'images/phone.png',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EnterNumberScreen()));
                                          },
                                        ),
                                        CustomOutlineButton(
                                          image: 'images/facebook.png',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    MaterialButton(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 7.h,
                                      minWidth: 50.w,
                                      onPressed: () {
                                        if (loginEmailController
                                                .text.isNotEmpty &&
                                            loginPasswordController
                                                .text.isNotEmpty) {
                                          login.LoginMethod1(
                                              context,
                                              loginEmailController.text
                                                  .trim()
                                                  .toString(),
                                              loginPasswordController.text
                                                  .trim()
                                                  .toString());
                                        } else {
                                          ErrorDialoge(context,
                                              "Email and Password couldn't be empty");
                                        }
                                      },
                                      color: Color(0xffffbd30),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SignUpPage();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onbackbuttonpressed(BuildContext context) {}
}

// bottomNavigationBar: BottomAppBar(
//     color: Colors.white,
//     elevation: 0,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't have an account?",
//           style: TextStyle(
//               fontSize: 2.3.h,
//               fontWeight: FontWeight.bold,
//               color: Colors.yellow[800]),
//         ),
//         TextButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const SignUpPage()));
//             },
//             child: Text(
//               "Sign Up",
//               style: TextStyle(
//                 color: Colors.indigo,
//                 fontWeight: FontWeight.bold,
//               ),
//             ))
//       ],
//     )),
// body: Container(
//   color: Colors.white,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RichText(
//             text: TextSpan(
//               children: <TextSpan>[
//                 TextSpan(
//                     text: "Login ",
//                     style: TextStyle(
//                         fontSize: 4.h,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.indigo)),
//                 TextSpan(
//                     text: " Here!",
//                     style: TextStyle(
//                         fontSize: 4.h,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange[600])),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 6.w,
//           ),
//           Image(
//             image: const AssetImage("images/ecommerce.png"),
//             height: 8.h,
//           ),
//         ],
//       ),
//       Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Textfield(
//                 email: emailcontroller,
//                 icon: Icons.alternate_email,
//                 hintext: "Email",
//                 mesege: 'Enter Email',
//               ),
//               Textfield(
//                 email: passwordcontroller,
//                 icon: Icons.key,
//                 hintext: "Password",
//                 mesege: 'Enter Password',
//               )
//             ],
//           )),
//       SizedBox(
//         height: 3.h,
//       ),
//       MaterialButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             print("Validation Working");
//
//             login.LoginMethod1(
//                 context,
//                 emailcontroller.text.trim().toString(),
//                 passwordcontroller.text.trim().toString());
//           }
//         },
//         color: Colors.orange[600],
//         height: 7.h,
//         minWidth: 30.w,
//         child: Text(
//           "Login",
//           style: TextStyle(
//               fontSize: 2.3.h,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//         ),
//       ),
//       SizedBox(
//         height: 4.h,
//       ),
//       MaterialButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => EnterNumberScreen()));
//         },
//         color: Colors.orange[600],
//         height: 7.h,
//         minWidth: 30.w,
//         child: Text(
//           "Login With Phone Number",
//           style: TextStyle(
//               fontSize: 2.3.h,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//         ),
//       ),
//       SizedBox(
//         height: 1.h,
//       ),
//       MaterialButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         onPressed: () {
//           LoginWithGoogle.handleSignIn(context);
//         },
//         color: Colors.orange[600],
//         height: 7.h,
//         minWidth: 30.w,
//         child: Text(
//           "Login With Google",
//           style: TextStyle(
//               fontSize: 2.3.h,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//         ),
//       ),
//     ],
//   ),
// ),
