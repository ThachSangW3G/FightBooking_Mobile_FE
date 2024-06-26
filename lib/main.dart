import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flightbooking_mobile_fe/screens/home/home_screen.dart';
import 'package:flightbooking_mobile_fe/screens/info_guest/info_guest_screen.dart';
import 'package:flightbooking_mobile_fe/screens/login_signup/login_screen.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_screen.dart';
import 'package:flightbooking_mobile_fe/screens/seat/seat_selection_screen.dart';

import 'package:flightbooking_mobile_fe/screens/splash/logo_screen.dart';
import 'package:flightbooking_mobile_fe/screens/splash/splash_one_screen.dart';
import 'package:flightbooking_mobile_fe/screens/trip_summary/trip_summary_screen.dart';
import 'package:flutter/material.dart';
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
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //`
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
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
        home: LoginScreen());
  }
}
