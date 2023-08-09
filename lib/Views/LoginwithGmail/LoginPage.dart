import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../Controller/Login/LoginMethod.dart';
import '../../Widgets/TextField.dart';
import '../LoginWithPhoneNumber/EnterNumber.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  LoginMethod login = Get.put(LoginMethod());

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 2.3.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[800]),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              )),
          body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login ",
                              style: TextStyle(
                                  fontSize: 4.h,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo)),
                          TextSpan(
                              text: " Here!",
                              style: TextStyle(
                                  fontSize: 4.h,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[600])),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Image(
                      image: const AssetImage("images/ecommerce.png"),
                      height: 8.h,
                    ),
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Textfield(
                          email: emailcontroller,
                          icon: Icons.alternate_email,
                          hintext: "Email",
                          mesege: 'Enter Email',
                        ),
                        Textfield(
                          email: passwordcontroller,
                          icon: Icons.key,
                          hintext: "Password",
                          mesege: 'Enter Password',
                        )
                      ],
                    )),
                SizedBox(
                  height: 3.h,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Validation Working");

                      login.LoginMethod1(
                          context,
                          emailcontroller.text.trim().toString(),
                          passwordcontroller.text.trim().toString());
                    }
                  },
                  color: Colors.orange[600],
                  height: 7.h,
                  minWidth: 30.w,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 2.3.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterNumberScreen()));
                  },
                  color: Colors.orange[600],
                  height: 7.h,
                  minWidth: 30.w,
                  child: Text(
                    "Login With Phone Number",
                    style: TextStyle(
                        fontSize: 2.3.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onbackbuttonpressed(BuildContext context) {}
}
