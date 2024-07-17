import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internshala_assignment/provider/filter_provider.dart';
import 'package:internshala_assignment/screens/home_screen.dart';
import 'package:internshala_assignment/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.73, 851.64),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider<FilterProvider>(
        create: (_) => FilterProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
