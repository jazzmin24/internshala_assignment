import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';

class AddWidget extends StatelessWidget {
  final String text;
  const AddWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: blueColor,
            size: 20.sp,
          ),
          SizedBox(width: 15.w),
          Text(
            text,
            style: GoogleFonts.inter(
              color: blueColor,
              letterSpacing: -0.1,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
