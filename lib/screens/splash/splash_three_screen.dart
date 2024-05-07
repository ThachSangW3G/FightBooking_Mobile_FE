import 'package:flightbooking_mobile_fe/components/splash/button_next.dart';
import 'package:flightbooking_mobile_fe/components/splash/line_blue_long.dart';
import 'package:flightbooking_mobile_fe/components/splash/line_blue_short.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashThreeScreen extends StatefulWidget {
  const SplashThreeScreen({super.key});

  @override
  State<SplashThreeScreen> createState() => _SplashThreeScreenState();
}

class _SplashThreeScreenState extends State<SplashThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.1,
                left: MediaQuery.sizeOf(context).width * 0.1,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LineBlueSort(),
                        SizedBox(
                          width: 7,
                        ),
                        LineBlueSort(),
                        SizedBox(
                          width: 7,
                        ),
                        LineBlueLong()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonNext(
                      onTap: () {
                        Get.to(() => const LoginScreen(),
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
                    'Make your own trip',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.sizeOf(context).width * 0.08,
              top: MediaQuery.sizeOf(context).height * 0.3,
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
                    'Make your own trip',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.sizeOf(context).width * 0.08,
              top: MediaQuery.sizeOf(context).height * 0.5,
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
                    'Make your own trip',
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
