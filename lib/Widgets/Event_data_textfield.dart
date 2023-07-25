import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Event_Textfield extends StatelessWidget {
final bool readOnly;
  final TextEditingController text;
  final IconData icon;
  final String hintext;
  final Function() onpressed;
  final Function(String value) onChanged;
  const Event_Textfield({Key? key,
    required this.onChanged,
    required this.onpressed,
    required this.text,
    required this.icon,
    required this.hintext, required this.readOnly,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
        child: Container(
          decoration: BoxDecoration(
             border: Border.all(
               color: Colors.black,
               width: 1
             ),
              borderRadius: BorderRadius.circular(10),
          ),
          height: 6.h,

          child: Center(
            child: TextFormField(
              readOnly: readOnly,
          onChanged: onChanged,
onTap: onpressed,
              controller: text,
              decoration: InputDecoration(
                focusColor: Colors.white,
                border: InputBorder.none,
                hintText: hintext,
                prefixIcon: InkWell(

                    child: Icon(icon)),
              ),
            ),
          ),
        ),
      );
  }
}
