import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce/Controller/Event_controllers/Upload_Event.dart';
import 'package:e_commerce/Widgets/Event_data_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Localization/code/local_keys.g.dart';
import '../../Models/UserModel.dart';
import 'package:file_picker/file_picker.dart';
class Add_Event extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const Add_Event({Key? key, required this.userModel, required this.firebaseuser}) : super(key: key);

  @override
  State<Add_Event> createState() => _Add_EventState();
}

class _Add_EventState extends State<Add_Event> {
  File? imageFile;

  Upload_Event upload= Upload_Event();
  Future<void> _selectEventDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        String date = picked.toString();
        List<String> date1 = date.split(" ");
        dateTime.text = date1[0];
      });
  }
  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        endTime.text = selectedTime.toString();
      });
    }
  }
  void _selectStartTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        startTime.text = selectedTime.toString();
      });
    }
  }
  selectImageSource(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15)
            )
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding:  EdgeInsets.all(4.h),
            child: Wrap(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 2.h),
                  child: ListTile(
                    selectedTileColor: Colors.yellow[800],
                    selected: true,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    onTap: (){

                      getImageFromGallery();

                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.image,
                      color: Colors.black,),
                    title: Text('Gallery',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                ),
                ListTile(
                  selectedTileColor: Colors.yellow[800],
                  selected: true,
                  splashColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onTap: (){

                    getImageFromCamera();
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt,color: Colors.black,),
                  title: Text('Camera',style: TextStyle(
                    color: Colors.black,
                  ),),
                ),

              ],
            ),
          );
        }
    );
  }
  getImageFromCamera (){
    Future<void> getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path );
        });

      }
    }

    getFromGallery();
  }
  getImageFromGallery (){
    Future<void> getFromGallery() async {

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path );
        });

      }
    }

    getFromGallery();
  }
  TextEditingController eventName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController maxEntries = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController frequency = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description=TextEditingController();
  String privacy = 'Public';
  String eventStatus = 'Closed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],

      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size*0.1,
        child: Padding(
          padding:  EdgeInsets.only(top: 2.h),

          child: AppBar(
            elevation: 0,
backgroundColor: Colors.orange[300],
            centerTitle: true,
            automaticallyImplyLeading: false,

            title: Text(LocaleKeys.add_new,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 3.h
            ),).tr(),

          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: Container(
                  height: 6.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[300]),
                  child: Center(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.orange[300],
                      value: privacy,
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        assert(newValue != null);
                        setState(() {
                          privacy = newValue!;
                        });
                      },
                      items: <String>[
                        'Public',
                        'Private',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: DottedBorder(
                  radius: Radius.circular(20),
                  color: Colors.black,
                  strokeWidth: 2,
                  child: InkWell(
                    onTap: (){
                      selectImageSource();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      height: 20.h,
                      width: MediaQuery.of(context).size.width,
                      child: imageFile!=null?Image( fit: BoxFit.cover,image: FileImage(imageFile!,)):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              height: 6.h,
                              image: AssetImage("images/upload.png")),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            LocaleKeys.tap_to_upload,
                            style: TextStyle(
                                fontSize: 3.h, fontWeight: FontWeight.bold),
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Event_Textfield(
                readOnly: false,
                text: eventName,
                icon: Icons.event,
                hintext: LocaleKeys.event_name.tr(),
                onpressed: () {},
                onChanged: (value){},
              ),
              Event_Textfield(
                readOnly: false,
                  text: location,
                  icon: Icons.location_on_outlined,
                  hintext: LocaleKeys.location.tr(),
                  onpressed: () {},
                onChanged: (value){},
              ),
              Row(
                children: [
                  Expanded(
                      child: Event_Textfield(
                          readOnly: true,
                          onChanged: (value){},
                          text: dateTime,
                          icon: Icons.event,
                          hintext: LocaleKeys.date.tr(),
                          onpressed: () {
                            _selectEventDate(context);
                          })),

                  Expanded(
                      child: Event_Textfield(
                          readOnly: false,
                          onChanged: (value){},
                          text: maxEntries,
                          icon: Icons.tag,
                          hintext: LocaleKeys.max_entries.tr(),
                          onpressed: () {})),
                ],
              ),
              Event_Textfield(
                  readOnly: false,
                  onChanged: (value){},
                  text: tags,
                  icon: Icons.tag,
                  hintext: LocaleKeys.tags.tr(),
                  onpressed: () {}),
              Event_Textfield(
                  readOnly: false,
                  onChanged: (value){},
                  text: frequency,
                  icon: Icons.cached,
                  hintext: LocaleKeys.frequency.tr(),
                  onpressed: () {}),
              Row(
                children: [
                  Expanded(
                      child: Event_Textfield(
                          readOnly: true,
                          onChanged: (value){},
                          text: startTime,
                          icon: Icons.alarm_on,
                          hintext: LocaleKeys.start_time.tr(),
                          onpressed: () {
                            _selectStartTime(context);
                          })),
                  Expanded(
                      child: Event_Textfield(
                          readOnly: true,
                          onChanged: (value){},
                          text: endTime,
                          icon: Icons.alarm_on,
                          hintext: LocaleKeys.end_time.tr(),
                          onpressed: () {
                            _selectEndTime(context);
                          })),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Text(
                  LocaleKeys.description_title.tr(),
                  style:
                      TextStyle(fontSize: 2.5.h, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: TextField(
                  controller: description,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText:
                    LocaleKeys.description.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Text(
                  LocaleKeys.who_can_invite.tr(),
                  style:
                      TextStyle(fontSize: 2.5.h, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    Container(
                      height: 6.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange[300]),
                      child: Center(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.orange[300],
                          value: eventStatus,
                          underline: Container(),
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            assert(newValue != null);
                            setState(() {
                              eventStatus = newValue!;
                            });
                          },
                          items: <String>[
                            'Closed',
                            'Open',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Event_Textfield(
                            readOnly: false,
                            onChanged: (value){},
                            text: price,
                            icon: Icons.currency_bitcoin,
                            hintext: LocaleKeys.price.tr(),
                            onpressed: () {})),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          String creationTime=DateTime.now().toString();
                          upload.upload(
                              context,
                            [widget.userModel.uid.toString(),widget.userModel.profilepic.toString(),widget.userModel.fullName.toString(),widget.userModel.email.toString()],
                            imageFile!,
                              description.text.toString(),
                              eventName.text.toString(),
                              location.text.toString(),
                              dateTime.text.toString(),
                              maxEntries.text.toString(),
                              tags.text.toString(),
                              frequency.text.toString(),
                              startTime.text.toString(),
                              endTime.text.toString(),
                              price.text.toString(),
                              privacy, eventStatus,
                              [widget.userModel.uid.toString()],
                              [widget.userModel.uid.toString()],
                            creationTime,


                          );
                        },
                        color: Colors.orange[300],
                        height: 7.h,
                        child: Text(
                          LocaleKeys.add.tr(),
                          style: TextStyle(
                              fontSize: 2.3.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
