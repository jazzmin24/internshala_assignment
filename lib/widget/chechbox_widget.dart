import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';

class CheckboxWidget extends StatefulWidget {
  final String text;
  final bool isQue;
  const CheckboxWidget({super.key, required this.text, this.isQue = false});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: isChecked ? blueColor : greyColor,
              size: 22.sp,
            ),
            SizedBox(width: 5.w),
            Text(
              widget.text,
              style: GoogleFonts.inter(
                color: primaryColor,
                letterSpacing: 1,
                fontSize: 14.sp,
              ),
            ),
            if (widget.isQue)
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Icon(CupertinoIcons.question_circle,
                    color: primaryColor, size: 14.sp),
              )
          ],
        ),
      ),
    );
  }
}
