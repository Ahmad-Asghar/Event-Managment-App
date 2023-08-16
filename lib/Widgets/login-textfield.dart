import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAuthenticationTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String labelText;
  final IconData icon;
  final Function onChange;
  const CustomAuthenticationTextField({Key? key, required this.textFieldController, required this.labelText, required this.icon, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      onChanged: (String value){onChange(value);},
      controller: textFieldController,
      decoration: InputDecoration(
          prefixIcon:Container(
            width: 18.w,
            child: Row(
              children: [
                SizedBox(width: 13,),
                Icon(icon,color: Color(0xffb8babf),),
                SizedBox(width: 10,),
                Container(width: 1,height: 15,color:Color(0xffb7b5b5),),
              ],
            ),
          ),
          labelText:labelText,
          labelStyle: const TextStyle(
            color: Color(0xffb7b5b5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25,),
          )
      ),
    );
  }
}
