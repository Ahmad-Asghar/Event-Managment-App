import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomOutlineButton extends StatelessWidget {
 final  String image;
 final Function onTap;
  const CustomOutlineButton({Key? key, required this.image, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w),
      child: SizedBox(
        height: 6.h,
        width: 15.w,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color:  Color(0xfff4f5fa),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          onPressed: () {
            onTap();
          },
          child: Image(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
