import 'package:flightbooking_mobile_fe/screens/CheckOutScreens/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DefaultScreen(),
    );
  }
}
