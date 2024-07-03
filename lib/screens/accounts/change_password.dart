import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_border.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/user_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  UserController userController = Get.put(UserController());

  bool _isLoading = false;

  Future<void> changePassword() async {
    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmNewPassword = confirmNewPasswordController.text;

    if (oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      final snackdemo = SnackBar(
        content: Text(
          'Vui lòng điền đầy đủ thông tin!',
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

    if (newPassword != confirmNewPassword) {
      final snackdemo = SnackBar(
        content: Text(
          'Vui lòng xác nhận lại mật khẩu!',
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

    setState(() {
      _isLoading = true;
    });

    final success =
        await userController.changePassword(oldPassword, newPassword);

    if (success) {
      final snackdemo = SnackBar(
        content: Text(
          'Thay đổi mật khẩu thành công!',
          style: kLableW800White,
        ),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Get.back();
    } else {
      final snackdemo = SnackBar(
        content: Text(
          'Mật khẩu vừa nhập không chính xác!',
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

  bool _isObscuredOldPassword = true;
  bool _isObscuredNewPassword = true;
  bool _isObscuredConfirmNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Change password', style: kLableSize20w700Black),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Your previous password has been reseted. Please set a new password for your account.',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: oldPasswordController,
                        style: kLableTextBlackMinium,
                        obscureText: _isObscuredOldPassword,
                        decoration: InputDecoration(
                            contentPadding: borderRadiusTextField,
                            suffixIcon: IconButton(
                              icon: _isObscuredOldPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscuredOldPassword =
                                      !_isObscuredOldPassword;
                                });
                              },
                            ),
                            labelText: 'Old password',
                            labelStyle: kLableTextBlackMinium,
                            focusedBorder: borderTextFieldFocus,
                            border: borderTextField),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: newPasswordController,
                        style: kLableTextBlackMinium,
                        obscureText: _isObscuredNewPassword,
                        decoration: InputDecoration(
                            contentPadding: borderRadiusTextField,
                            suffixIcon: IconButton(
                              icon: _isObscuredNewPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscuredNewPassword =
                                      !_isObscuredNewPassword;
                                });
                              },
                            ),
                            labelText: 'New password',
                            labelStyle: kLableTextBlackMinium,
                            focusedBorder: borderTextFieldFocus,
                            border: borderTextField),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmNewPasswordController,
                        style: kLableTextBlackMinium,
                        obscureText: _isObscuredConfirmNewPassword,
                        decoration: InputDecoration(
                            contentPadding: borderRadiusTextField,
                            suffixIcon: IconButton(
                              icon: _isObscuredConfirmNewPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscuredConfirmNewPassword =
                                      !_isObscuredConfirmNewPassword;
                                });
                              },
                            ),
                            labelText: 'Confirm new password',
                            labelStyle: kLableTextBlackMinium,
                            focusedBorder: borderTextFieldFocus,
                            border: borderTextField),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonBlue(
                        isLoading: _isLoading,
                        onPress: changePassword,
                        des: 'Done',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]))));
  }
}
