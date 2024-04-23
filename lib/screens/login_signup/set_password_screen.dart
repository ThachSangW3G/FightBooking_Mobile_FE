import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/successfull_screen.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool _isObscured = false;
  bool _isObscuredConfirm = false;
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
                'Set a password',
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
                  'Your previous password has been reseted. Please set a new password for your account.',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 25,
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
              TextFormField(
                obscureText: _isObscuredConfirm,
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: 'Re-Enter Password',
                    hintText: '***********',
                    suffixIcon: IconButton(
                      icon: _isObscuredConfirm
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscuredConfirm = !_isObscuredConfirm;
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
                    fillColor: AppColors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonBlue(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessfullScreen()));
                },
                des: 'Set new password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
