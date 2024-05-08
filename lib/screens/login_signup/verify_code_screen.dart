import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/otp_input.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/auth_controller.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/set_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  List<String> otpValues = List.filled(6, '');

  AuthController authController = Get.put(AuthController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isLoading = false;

  Future<void> verifyCode() async {
    String code = '';
    otpValues.forEach((element) {
      if (element.isEmpty) {
        final snackdemo = SnackBar(
          content: Text(
            'Vui lòng điền đầy đủ mã OPT!',
            style: kLableW800White,
          ),
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        return;
      }

      code += element.toString();
    });

    int otp = int.parse(code);

    setState(() {
      _isLoading = true;
    });

    final success = await authController.verifyCode(otp);

    if (success) {
      Get.to(() => const SetPasswordScreen());
    } else {
      final snackdemo = SnackBar(
        content: Text(
          'Mã OPT không đúng!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> resend() async {
    final prefs = await _prefs;

    final email = prefs.getString('email');

    final success = await authController.forgotPassword(email!);

    if (success) {
      final snackdemo = SnackBar(
        content: Text(
          'Đã gửi lại mã OTP!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      final snackdemo = SnackBar(
        content: Text(
          'Gửi lại mã OTP thất bại!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Code',
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              Opacity(
                opacity: 0.75,
                child: Text(
                  'An authentication code has been sent to your email (Code with 6 digits).',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => OTPInput(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      setState(() {
                        otpValues[index] = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Didn’t receive a code?',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: resend,
                    child: Text(
                      'Resend',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: AppColors.slamon,
                              fontWeight: FontWeight.w400,
                              fontSize: 16)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonBlue(
                isLoading: _isLoading,
                onPress: verifyCode,
                des: 'Verify',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
