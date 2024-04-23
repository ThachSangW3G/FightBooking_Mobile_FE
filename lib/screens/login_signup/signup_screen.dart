import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  bool _isObscured = false;
  bool _isObscuredConfirm = false;
  DateTime? selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
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
                'Sign Up',
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
                  'Let’s get you all st up so you can access your personal account.',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Full Name',
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
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Email',
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
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                      fillColor: AppColors.white),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) {},
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : '',
                  ),
                  decoration: InputDecoration(
                      labelText: 'Day of birth',
                      hintText: '16/12/2003',
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
                      suffixIcon: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: const Icon(Icons.date_range_outlined),
                      ),
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
              TextFormField(
                obscureText: _isObscuredConfirm,
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    activeColor: AppColors.blue,
                  ),
                  Expanded(
                    child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: AppColors.stack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            children: const [
                              TextSpan(text: 'I agree to all to '),
                              TextSpan(
                                  text: 'Term',
                                  style: TextStyle(color: AppColors.slamon)),
                              TextSpan(text: ' and '),
                              TextSpan(
                                  text: 'Privacy Policies',
                                  style: TextStyle(color: AppColors.slamon)),
                            ])),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonBlue(
                onPress: () {},
                des: 'Sign Up',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
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
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      'Login',
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
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
