import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';
import 'package:internshala_assignment/provider/filter_provider.dart';
import 'package:internshala_assignment/screens/filter_screen.dart';
import 'package:internshala_assignment/widget/icon_text_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Provider.of<FilterProvider>(context, listen: false).fetchInternships();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FilterProvider filterProvider = Provider.of<FilterProvider>(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Icon(
              Icons.menu,
              color: primaryColor,
              size: 23.sp,
            ),
            SizedBox(width: 5.w),
            Text(
              'Internships',
              style: GoogleFonts.inter(
                color: primaryOnColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            Spacer(),
            Icon(
              CupertinoIcons.search,
              color: primaryColor,
              size: 20.sp,
            ),
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
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(255, 222, 222, 222),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      Provider.of<FilterProvider>(context, listen: false)
                          .clearFilters();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilterScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: blueColor,
                        ),
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: blueColor,
                              size: 18.sp,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'Filters',
                              style: GoogleFonts.inter(
                                color: blueColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Consumer<FilterProvider>(builder: (context, provider, child) {
                    return Text(
                      '${provider.filteredInternships.isEmpty ? provider.internships.length : provider.filteredInternships.length} total internships',
                      style: GoogleFonts.inter(
                        color: greyColor,
                        letterSpacing: -0.1,
                        fontSize: 14.sp,
                      ),
                    );
                  })
                ],
              ),
            ),
            Expanded(
              child: Consumer<FilterProvider>(
                builder: (context, provider, child) {
                  if (provider.internships.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.filteredInternships.isNotEmpty) {
                    return ListView.builder(
                      itemCount: provider.filteredInternships.length,
                      itemBuilder: (context, index) {
                        final internship = provider.filteredInternships[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            height: 320.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 222, 222, 222)),
                                bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 222, 222, 222)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          internship.title,
                                          style: GoogleFonts.inter(
                                            color: primaryOnColor,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.5,
                                            fontSize: 19.sp,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            internship.companyName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.inter(
                                              color: greyColor,
                                              letterSpacing: -0.5,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      'assets/trusted.png',
                                      height: 48.h,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                IconTextRow(
                                    iconData: Icons.location_on_outlined,
                                    text: internship.locationNames.join(', ')),
                                Row(
                                  children: [
                                    IconTextRow(
                                        iconData: Icons.play_circle_outline,
                                        text: internship.startDate),
                                    SizedBox(width: 15.w),
                                    IconTextRow(
                                        iconData: Icons.calendar_today_outlined,
                                        text: internship.duration),
                                  ],
                                ),
                                IconTextRow(
                                    iconData: Icons.credit_card_outlined,
                                    text: internship.stipend),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: scaffoldColor,
                                  ),
                                  child: Text(
                                    internship.employmentType,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: greyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: scaffoldColor,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.play_for_work,
                                        size: 12.sp,
                                        color: greyColor,
                                      ),
                                      Text(
                                        internship.postedOn,
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          color: greyColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Divider(color: scaffoldColor),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                          'View Details',
                                          style: GoogleFonts.inter(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 45.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: blueColor,
                                          ),
                                          child: Text(
                                            'Apply now',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: provider.internships.length,
                      itemBuilder: (context, index) {
                        final internship = provider.internships[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            height: 320.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 222, 222, 222)),
                                bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 222, 222, 222)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          internship.title,
                                          style: GoogleFonts.inter(
                                            color: primaryOnColor,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.5,
                                            fontSize: 19.sp,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            internship.companyName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.inter(
                                              color: greyColor,
                                              letterSpacing: -0.5,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      'assets/trusted.png',
                                      height: 48.h,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                IconTextRow(
                                    iconData: Icons.location_on_outlined,
                                    text: internship.locationNames.join(', ')),
                                Row(
                                  children: [
                                    IconTextRow(
                                        iconData: Icons.play_circle_outline,
                                        text: internship.startDate),
                                    SizedBox(width: 15.w),
                                    IconTextRow(
                                        iconData: Icons.calendar_today_outlined,
                                        text: internship.duration),
                                  ],
                                ),
                                IconTextRow(
                                    iconData: Icons.credit_card_outlined,
                                    text: internship.stipend),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: scaffoldColor,
                                  ),
                                  child: Text(
                                    internship.employmentType,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      color: greyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: scaffoldColor,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.play_for_work,
                                        size: 12.sp,
                                        color: greyColor,
                                      ),
                                      Text(
                                        internship.postedOn,
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          color: greyColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Divider(color: scaffoldColor),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text(
                                          'View Details',
                                          style: GoogleFonts.inter(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 45.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: blueColor,
                                          ),
                                          child: Text(
                                            'Apply now',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
