import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger, // Set background color to blue
        leading: IconButton(
          color: AppColors.white, // Set icon color to white
          icon:
              Image.asset('assets/icons/nav_back_icon.png'), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to homepage
          },
        ),
        title: const Text(
          'Thông tin thanh toán',
          style: TextStyle(
            color: Colors.white, // Text color
            fontFamily: 'Inter', // Font family
            fontSize: 20.0, // Font size
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0), // Add padding around content
        decoration: const BoxDecoration(
          color: AppColors.white, // Set background color to white
          borderRadius:
              BorderRadius.all(Radius.circular(8.0)), // Add rounded corners
        ),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to start
            children: [
              SizedBox(
                height: 24,
                child: Text(
                  'Chi tiết đơn hàng',
                  style: TextStyle(
                    color: Color(0xFF27272A),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.09,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FlightTicket {
  String destination;
  int quantity;
  double price;

  FlightTicket(
      {required this.destination, required this.quantity, required this.price});
}

List<FlightTicket> bookedFlights = [
  FlightTicket(destination: "Hà Nội", quantity: 2, price: 2100000.0),
  FlightTicket(destination: "Đà Nẵng", quantity: 1, price: 1500000.0),
  FlightTicket(destination: "TP. Hồ Chí Minh", quantity: 3, price: 3000000.0),
];
