import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/config/colors.dart';
import 'package:internshala_assignment/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    SearchScreen(),
    Center(child: Text('Jobs Page')),
    Center(child: Text('Clubs Page')),
    Center(child: Text('Courses Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.paperplane),
            activeIcon: Icon(CupertinoIcons.paperplane_fill),
            label: 'Internships',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            activeIcon: Icon(Icons.card_travel),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2),
            activeIcon: Icon(CupertinoIcons.person_2_fill),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tv),
            activeIcon: Icon(CupertinoIcons.tv),
            label: 'Courses',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: blueColor,
        unselectedItemColor: primaryColor,
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal),
        onTap: _onItemTapped,
      ),
    );
  }
}
