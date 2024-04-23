import 'dart:async';

import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/splash/splash_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashOneScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/svgs/logo.svg',
          width: 200,
          height: 300,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
