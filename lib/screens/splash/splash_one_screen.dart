import 'dart:async';

import 'package:flightbooking_mobile_fe/components/splash/button_next.dart';
import 'package:flightbooking_mobile_fe/components/splash/line_blue_long.dart';
import 'package:flightbooking_mobile_fe/components/splash/line_blue_short.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/splash/logo_screen.dart';
import 'package:flightbooking_mobile_fe/screens/splash/splash_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashOneScreen extends StatefulWidget {
  const SplashOneScreen({super.key});

  @override
  State<SplashOneScreen> createState() => _SplashOneScreenState();
}

class _SplashOneScreenState extends State<SplashOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.1,
                left: MediaQuery.sizeOf(context).width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LineBlueLong(),
                        SizedBox(
                          width: 7,
                        ),
                        LineBlueSort(),
                        SizedBox(
                          width: 7,
                        ),
                        LineBlueSort()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonNext(
                      onTap: () {
                        Get.to(() => const SplashTwoScreen(),
                            transition: Transition.rightToLeft);
                      },
                    )
                  ],
                )),
            Positioned(
              left: MediaQuery.sizeOf(context).width * 0.08,
              top: MediaQuery.sizeOf(context).height * 0.1,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).height * 0.15,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Welcome to\nFlight Booking',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
