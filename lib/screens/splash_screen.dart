import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_assignment/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Expanded(
            child: Center(
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/logo.png',
                  width: 220.w,
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/trusted.png',
            height: 50.h,
          ),
          Text(
            'Trusted by over 21 Million',
            style: GoogleFonts.inter(
              color: const Color(0xFF484848),
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          // SizedBox(height: 1.h),
          Text(
            'College Students and Graduates',
            style: GoogleFonts.inter(
              color: const Color(0xFF484848),
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50.h)
        ],
      ),
    );
  }
}
