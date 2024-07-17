import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';
import 'package:internshala_assignment/provider/filter_provider.dart';
import 'package:internshala_assignment/screens/search_screen.dart';
import 'package:provider/provider.dart';

class SelectionScreen extends StatefulWidget {
  final String screen;
  final String selection;

  const SelectionScreen({
    Key? key,
    required this.screen,
    required this.selection,
  }) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  TextEditingController _searchController = TextEditingController();
  late Set<String> _displayedValues;
  late List<bool> _isCheckedList;
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    _updateDisplayedValues('');
    _isCheckedList = List.filled(_displayedValues.length, false);
  }

  void _updateDisplayedValues(String query) {
    FilterProvider filterProvider =
        Provider.of<FilterProvider>(context, listen: false);
    Set<String> values = widget.selection == 'title'
        ? filterProvider.internships.map((e) => e.title).toSet()
        : filterProvider.internships.expand((e) => e.locationNames).toSet();

    _displayedValues = values
        .where((value) => value.toLowerCase().contains(query.toLowerCase()))
        .toSet();
  }

  // void _applyFilters() {
  //   FilterProvider filterProvider =
  //       Provider.of<FilterProvider>(context, listen: false);
  //   if (widget.selection == 'title') {
  //     filterProvider.applyFilters(selectedValues, {});
  //   } else {
  //     filterProvider.applyFilters({}, selectedValues);
  //   }
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => SearchScreen(),
  //     ),
  //   );
  //   // // Manually format the output
  //   // List<String> formattedInternships =
  //   //     filterProvider.filteredInternships.map((internship) {
  //   //   return 'Title: ${internship.title}, Locations: ${internship.locationNames.join(', ')}';
  //   // }).toList();
  //   // log('//====check');
  //   // //log(formattedInternships);
  //   // print(formattedInternships);
  //   // //Navigator.pop(context);
  // }

  void _clearFilters() {
    FilterProvider filterProvider =
        Provider.of<FilterProvider>(context, listen: false);
    filterProvider.clearFilters();
    setState(() {
      _isCheckedList = List.filled(_displayedValues.length, false);
      selectedValues.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    FilterProvider filterProvider = Provider.of<FilterProvider>(context);
    return WillPopScope(
     onWillPop: () async {
        // Logic to execute when the back button is pressed
        if (widget.screen == "Profile") {
          filterProvider.profileFilterListUpdate(selectedValues);
        } else {
          filterProvider.cityFilterListUpdate(selectedValues);
        }
        filterProvider.filterInternships();
        return true; // Return true to allow back navigation
      },  
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: -6.w,
          title: Row(
            children: [
              Text(
                widget.screen,
                style: GoogleFonts.inter(
                  color: primaryOnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  'Clear all',
                  style: GoogleFonts.inter(
                    color: blueColor,
                    letterSpacing: -0.1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  //  onTap: _applyFilters,
                  onTap: () {
                    if (widget.screen == "Profile") {
                      filterProvider.profileFilterListUpdate(selectedValues);
                    } else {
                      filterProvider.cityFilterListUpdate(selectedValues);
                    }
                    filterProvider.filterInternships();
      
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: blueColor,
                    ),
                    child: Text(
                      'Apply',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.bell,
                color: primaryColor,
                size: 20.sp,
              ),
              SizedBox(width: 22.w),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 13.h),
              TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _updateDisplayedValues(value);
                    _isCheckedList = List.filled(_displayedValues.length, false);
                  });
                },
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.h),
                  labelText: 'Search Profile',
                  labelStyle: GoogleFonts.inter(color: blueColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: blueColor, width: 2.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blueColor, width: 2.w),
                  ),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                cursorColor: blueColor,
              ),
      
              // Selected values display
              if (selectedValues.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: selectedValues
                          .map((value) => Chip(
                                labelPadding: EdgeInsets.zero,
                                label: Text(
                                  "$value ",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: blueColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(color: blueColor)),
                                deleteIcon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                deleteButtonTooltipMessage: 'Remove',
                                onDeleted: () {
                                  setState(() {
                                    selectedValues.remove(value);
                                    _isCheckedList[_displayedValues
                                        .toList()
                                        .indexOf(value)] = false;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
      
              Expanded(
                child: ListView.builder(
                  itemCount: _displayedValues.length,
                  itemBuilder: (context, index) {
                    String value = _displayedValues.toList()[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isCheckedList[index] = !_isCheckedList[index];
                          // if (_isCheckedList[index] ) {
      
                          //   selectedValues.add(value);
                          // } else {
                          //   selectedValues.remove(value);
                          // }
      
                          if (widget.screen == "Profile") {
                            if (_isCheckedList[index]) {
                              selectedValues.add(value);
                            } else {
                              selectedValues.remove(value);
                            }
                          } else {
                            if (_isCheckedList[index]) {
                              selectedValues.add(value);
                            } else {
                              selectedValues.remove(value);
                            }
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Icon(
                              _isCheckedList[index]
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color:
                                  _isCheckedList[index] ? blueColor : greyColor,
                              size: 22.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              value,
                              style: GoogleFonts.inter(
                                color: primaryColor,
                                letterSpacing: 1,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
