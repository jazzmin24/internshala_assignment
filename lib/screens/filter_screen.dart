import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';
import 'package:internshala_assignment/provider/filter_provider.dart';
import 'package:internshala_assignment/screens/search_screen.dart';
import 'package:internshala_assignment/screens/selection_screen.dart';
import 'package:internshala_assignment/widget/add_widget.dart';
import 'package:internshala_assignment/widget/chechbox_widget.dart';
import 'package:internshala_assignment/widget/small_text_eidget.dart';
import 'package:internshala_assignment/widget/stipend_widget.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedDuration;
  List<String> durations = [];

  @override
  void initState() {
    super.initState();
    _fetchDurations();
  }

  Future<void> _fetchDurations() async {
    try {
      FilterProvider filterProvider =
          Provider.of<FilterProvider>(context, listen: false);
      Set<String> values =
          filterProvider.internships.map((e) => e.duration).toSet();
      setState(() {
        durations = values.toList();
      });
    } catch (e) {
      print('Failed to fetch durations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        titleSpacing: -6.w,
        title: Row(
          children: [
            Text(
              'Filters',
              style: GoogleFonts.inter(
                color: primaryOnColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Icon(
                CupertinoIcons.bookmark,
                color: primaryColor,
                size: 20.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                CupertinoIcons.bell,
                color: primaryColor,
                size: 20.sp,
              ),
            ),
            Icon(
              CupertinoIcons.text_bubble,
              color: primaryColor,
              size: 20.sp,
            ),
            SizedBox(width: 22.w)
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 13.sp, left: 18.sp, right: 18.sp),
        child: ListView(
          children: [
            SizedBox(height: 12.h),
            Row(
              children: [
                const CheckboxWidget(text: 'As per my '),
                Text(
                  'preferences',
                  style: GoogleFonts.inter(
                    color: blueColor,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const SmallTextWidget(text: 'PROFILE'),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(
                      screen: 'Profile',
                      selection: 'title',
                    ),
                  ),
                );
              },
              child: const AddWidget(text: 'Add profile'),
            ),
            const SmallTextWidget(text: 'CITY'),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(
                      screen: 'City',
                      selection: 'city',
                    ),
                  ),
                );
              },
              child: const AddWidget(text: 'Add city'),
            ),
            const SmallTextWidget(text: 'INTERNSHIP TYPE'),
            const CheckboxWidget(
              text: 'Work from home',
            ),
            const CheckboxWidget(text: 'Part-time'),
            SizedBox(height: 8.h),
            const SmallTextWidget(text: 'MONTHLY STIPEND (INR)'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StipendWidget(text: '2,000'),
                StipendWidget(text: '3,000'),
                StipendWidget(text: '4,000'),
                StipendWidget(text: '5,000'),
              ],
            ),
            const Row(
              children: [
                StipendWidget(text: '10,000'),
              ],
            ),
            const SmallTextWidget(text: 'STARTING FROM (OR AFTER)'),
            Container(
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color.fromARGB(255, 215, 211, 211),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Date',
                        style: GoogleFonts.inter(
                          color: greyColor,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        color: greyColor,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SmallTextWidget(text: 'MAXIMUM DURATION (IN MONTHS)'),

            // DropdownButtonFormField for duration selection
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.h,
                ),
                labelText: 'Choose Duration',
                labelStyle: GoogleFonts.inter(
                  color: selectedDuration != null ? blueColor : greyColor,
                  fontSize: 14.sp,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 215, 211, 211),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide(color: blueColor, width: 2.w),
                ),
              ),
              value: selectedDuration,
              items: durations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedDuration = newValue!;
                  Provider.of<FilterProvider>(context, listen: false)
                      .durationFilterListUpdate([newValue]);
                });
              },
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 8.sp),
                child: Icon(
                  CupertinoIcons.chevron_down,
                  color: selectedDuration != null ? blueColor : greyColor,
                  size: 14.sp,
                ),
              ),
            ),

            const SmallTextWidget(text: 'MORE FILTER'),
            const CheckboxWidget(
              text: 'Internships with job offer',
              isQue: true,
            ),
            const CheckboxWidget(
              text: 'Fast response',
              isQue: true,
            ),
            const CheckboxWidget(
              text: 'Early applicant',
              isQue: true,
            ),
            const CheckboxWidget(
              text: 'Internships for women',
              isQue: true,
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 86.h,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Container(
                  height: 50.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: blueColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Clear All',
                      style: GoogleFonts.inter(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 18.h),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<FilterProvider>(context, listen: false)
                        .filterInternships();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 50.h,
                    width: 170.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: blueColor,
                    ),
                    child: Center(
                      child: Text(
                        'Apply',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
