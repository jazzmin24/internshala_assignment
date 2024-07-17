import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart'; // Ensure you have imported the screenutil package

class IconTextRow extends StatelessWidget {
  final IconData iconData;
  final String text;

  IconTextRow({
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(iconData, size: 16.sp, color: primaryColor),
            SizedBox(width: 2.w),
            Text(
              text,
              style: GoogleFonts.inter(
                color: primaryColor,
                letterSpacing: -0.1,
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h)
      ],
    );
  }
}
