import 'package:flightbooking_mobile_fe/components/accounts/tile.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisper,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.slamon,
                        ),
                        child: ClipOval(
                          child: Image.asset('assets/images/default_avatar.jpg',
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: InkWell(
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blue),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/camera.svg',
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    //userController.currentUser.value!.fullName!,
                    'Nguyễn Thế Hùng',
                    style: kLableTextBlackW600,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    //userController.currentUser.value!.email!,
                    'DkQXG@example.com',
                    style: kLableTextStyleMiniumGrey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: const Tile(
                        icon: 'assets/icons/aboutme.svg',
                        haveArrowRight: true,
                        title: 'About me'),
                  ),
                  InkWell(
                    child: const Tile(
                        icon: 'assets/icons/notification.svg',
                        haveArrowRight: true,
                        title: 'Notifications'),
                  ),
                  InkWell(
                    child: const Tile(
                        icon: 'assets/icons/notification.svg',
                        haveArrowRight: true,
                        title: 'Change password'),
                  ),
                  const Tile(
                      icon: 'assets/icons/notification.svg',
                      haveArrowRight: true,
                      title: 'Policy'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Other',
                        style: kLableTextStyle18Grey,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Tile(
                      icon: 'assets/icons/version.svg',
                      haveArrowRight: false,
                      title: 'Version',
                      rightContent: '1.1.0'),
                  InkWell(
                    onTap: () async {
                      final SharedPreferences prefs = await _prefs;
                      prefs.clear();
                      Get.offAll(() => const LoginScreen());
                    },
                    child: const Tile(
                      icon: 'assets/icons/signout.svg',
                      haveArrowRight: false,
                      title: 'Sign out',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
