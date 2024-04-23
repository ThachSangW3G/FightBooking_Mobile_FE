import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_icon.dart';
import 'package:flightbooking_mobile_fe/components/splash/button_next.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/forgot_password_screen.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  bool _isObscured = true;
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
                'Login',
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
                  'Login to access your Golobe account',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'trungtinh1620@gmail.com',
                      enabledBorder: const OutlineInputBorder(
                        // viền khi không có focus
                        borderSide: BorderSide(color: AppColors.stack),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        // viền khi có focus
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      labelStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                      filled: true,
                      fillColor: AppColors.white)),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  obscureText: _isObscured,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '***********',
                      suffixIcon: IconButton(
                        icon: _isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        // viền khi không có focus
                        borderSide: BorderSide(color: AppColors.stack),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        // viền khi có focus
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      labelStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                      filled: true,
                      fillColor: AppColors.white)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: 0),
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        activeColor: AppColors.blue,
                      ),
                      Text(
                        'Remember me',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen()));
                    },
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: AppColors.slamon,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ButtonBlue(
                onPress: () {},
                des: 'Login',
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: AppColors.slamon,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      height: 1.0,
                      indent: 2.0,
                      color: AppColors.gray,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Or login with',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: AppColors.stack, fontSize: 16)),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 1.0,
                      color: AppColors.gray,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonIcon(
                    icon: 'assets/svgs/fb_logo.svg',
                    onPress: () {},
                  ),
                  ButtonIcon(
                    icon: 'assets/svgs/gg_logo.svg',
                    onPress: () {},
                  ),
                  ButtonIcon(
                    icon: 'assets/svgs/ap_logo.svg',
                    onPress: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
