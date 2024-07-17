import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';

class StipendWidget extends StatelessWidget {
  final String text;
  const StipendWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: blueColor,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.currency_rupee_outlined,
                color: blueColor,
                size: 15.sp,
              ),
              SizedBox(width: 1.w),
              Text(
                text,
                style: GoogleFonts.inter(
                    color: blueColor,
                    //    fontWeight: FontWeight.w400,
                    letterSpacing: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
