import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';

class SmallTextWidget extends StatelessWidget {
  final String text;
  const SmallTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Text(
        text,
        style: GoogleFonts.inter(
            color: greyColor, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
