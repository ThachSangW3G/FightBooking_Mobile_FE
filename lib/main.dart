import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flightbooking_mobile_fe/screens/home/home_screen.dart';
import 'package:flightbooking_mobile_fe/screens/info_guest/info_guest_screen.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_screen.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_selection_screen.dart';

import 'package:flightbooking_mobile_fe/screens/splash/logo_screen.dart';
import 'package:flightbooking_mobile_fe/screens/splash/splash_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const CheckoutScreen());
        // home: TripSummaryScreen(
        //     departureFlightId: 1,
        //     returnFlightId: 3,
        //     numAdults: 1,
        //     numChildren: 1,
        //     numInfants: 1));
        // home: DefaultScreen());
        // home: LoginScreen());
        home: LoginScreen());
  }
}
