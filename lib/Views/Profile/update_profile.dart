import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controller/Login/update_profile.dart';
import '../../Models/UserModel.dart';
import '../../Widgets/login-textfield.dart';

class UpdateProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const UpdateProfile(
      {Key? key, required this.userModel, required this.firebaseuser})
      : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  File? imageFile;

  selectImageSource() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(4.h),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: ListTile(
                    selectedTileColor: Colors.yellow[800],
                    selected: true,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onTap: () {
                      getImagefromGallery();

                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  selectedTileColor: Colors.yellow[800],
                  selected: true,
                  splashColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onTap: () {
                    getImagefromCamera();
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  getImagefromCamera() {
    Future<void> _getFromGallery() async {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path) as File?;
        });
      }
    }

    _getFromGallery();
  }

  getImagefromGallery() {
    Future<void> _getFromGallery() async {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path) as File?;
        });
      }
    }

    _getFromGallery();
  }

  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8.h,width: double.infinity,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'update profile',
                    style: TextStyle(
                      fontSize: 3.7.h,
                      //fontFamily: 'Poppins',
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
                    width: 40.w,
                  ),
                ],
              ),
              SizedBox(
                height:3.h,
              ),
              CupertinoButton(
                  onPressed: () {
                    selectImageSource();
                  },
                  child: CircleAvatar(
                      radius: 10.h,
                      child: imageFile != null
                          ? CircleAvatar(
                        backgroundImage: FileImage(
                          imageFile!,
                        ),
                        radius: 10.h,
                      )
                          : CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 10.0.h,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                widget.userModel.profilepic.toString(),
                              ),
                            ),
                          ),
                        ),
                      ))),
              SizedBox(height: 2.h,width: double.infinity,),
              CustomAuthenticationTextField(
                textFieldController: emailController,
                labelText: 'E-mail',
                icon: Icons.alternate_email_rounded,
                onChange: () {},
              ),
              SizedBox(height: 3.h,width: double.infinity,),
              CustomAuthenticationTextField(
                textFieldController: nameController,
                labelText: 'Full Name',
                icon: Icons.person_2_outlined,
                onChange: () {},
              ),
              SizedBox(height: 3.h,width: double.infinity,),
              MaterialButton(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 7.h,
                minWidth: 50.w,
                onPressed: () {
                  CompleteProfile.uploadProfilePic(context, imageFile!, emailController.text.trim().toString(), nameController.text.trim().toString(), widget.firebaseuser, widget.userModel);
                },
                color: Color(0xffffbd30),
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
