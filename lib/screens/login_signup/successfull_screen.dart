import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfullScreen extends StatefulWidget {
  const SuccessfullScreen({super.key});

  @override
  State<SuccessfullScreen> createState() => _SuccessfullScreenState();
}

class _SuccessfullScreenState extends State<SuccessfullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/successfull.png'))),
            ),
            SvgPicture.asset(
              'assets/svgs/successfull.svg"',
              width: 200,
              height: 300,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your password has been changed successfully !',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              )),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonBlue(
                des: 'Back to Login',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                })
          ],
        ),
      ),
    );
  }
}
