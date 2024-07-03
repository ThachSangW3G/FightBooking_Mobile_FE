import 'package:flightbooking_mobile_fe/components/accounts/title_switch.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool allowNotify = false;
  bool emailNotify = true;
  bool orderNotify = false;
  bool generalNotify = true;

  void onChangedAllowNotify(bool value) {
    setState(() {
      allowNotify = !allowNotify;
    });
  }

  void onChangedEmailNotify(bool value) {
    setState(() {
      emailNotify = !emailNotify;
    });
  }

  void onChangedOrderNotify(bool value) {
    setState(() {
      orderNotify = !orderNotify;
    });
  }

  void onChangedGeneralNotify(bool value) {
    setState(() {
      generalNotify = !generalNotify;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whisper,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: kLableTextBlackW600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Column(
                children: [
                  TitleSwitch(
                    title: 'Allow Notifcations',
                    content:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumym',
                    value: allowNotify,
                    onChanged: onChangedAllowNotify,
                  ),
                  TitleSwitch(
                    title: 'Email Notifcations',
                    content:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumym',
                    value: emailNotify,
                    onChanged: onChangedEmailNotify,
                  ),
                  TitleSwitch(
                    title: 'Order Notifcations',
                    content:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumym',
                    value: orderNotify,
                    onChanged: onChangedOrderNotify,
                  ),
                  TitleSwitch(
                    title: 'General Notifcations',
                    content:
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumym',
                    value: generalNotify,
                    onChanged: onChangedGeneralNotify,
                  ),
                ],
              ),
              Positioned(
                  bottom: 140,
                  child: ButtonBlue(
                    des: "Save settings",
                    onPress: () {
                      Get.back();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
