import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/components/info_guest/input_text.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/widgets/info_guest/info_widgets.dart';
import 'package:http/http.dart' as http;

class InfoGuestScreen extends StatefulWidget {
  final int numPassengers;
  final double totalPrice;
  final int departureFlightId;
  final int? returnFlightId;
  // final List<String> departureSelectSeats = [];
  // final List<String> arrivalSelectSeats = [];
  const InfoGuestScreen({
    super.key,
    required this.numPassengers,
    required this.totalPrice,
    required this.departureFlightId,
    this.returnFlightId,
  });

  @override
  State<InfoGuestScreen> createState() => _InfoGuestScreenState();
}

class _InfoGuestScreenState extends State<InfoGuestScreen> {
  final List<Map<String, String>> passengerDetails = [];
  final Map<String, String> contactDetails = {
    'fullName': '',
    'phone': '',
    'email': ''
  };

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numPassengers; i++) {
      passengerDetails.add(
          {'fullName': '', 'personalId': '', 'email': '', 'seatNumber': ''});
    }
  }

  List<Widget> _buildPassengerInfoFields() {
    List<Widget> fields = [];
    for (int i = 0; i < widget.numPassengers; i++) {
      fields.add(
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thông tin hành khách ${i + 1}',
                  style: kLableSize20w700Black),
              const SizedBox(height: 10),
              Row(
                children: [
                  InputTextComponent(
                      label: 'Tên',
                      name: '',
                      hinttext: 'VD: Trung Tinh',
                      onChanged: (value) {
                        setState(() {
                          passengerDetails[i]['fullName'] = value;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InputTextComponent(
                      label: 'CMND/Hộ chiếu',
                      name: '',
                      hinttext: 'VD: 123456789',
                      onChanged: (value) {
                        setState(() {
                          passengerDetails[i]['personalId'] = value;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InputTextComponent(
                      label: 'Email',
                      name: '',
                      hinttext: 'VD: example@gmail.com',
                      onChanged: (value) {
                        setState(() {
                          passengerDetails[i]['email'] = value;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InputTextComponent(
                      label: 'Số ghế',
                      name: '',
                      hinttext: 'VD: A1',
                      onChanged: (value) {
                        setState(() {
                          passengerDetails[i]['seatNumber'] = value;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return fields;
  }

  Future<void> _submitDetails() async {
    await _createPayment(widget.departureFlightId);
    if (widget.returnFlightId != null) {
      await _createPayment(widget.returnFlightId!);
    }
    Get.to(() => const CheckoutScreen());
  }

  Future<void> _createPayment(int flightId) async {
    final response = await http.post(
      Uri.parse(
          'https://flightbookingbe-production.up.railway.app/payment/create-payment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': 'your_token_here', // Add your token here
        'idVoucher': 0, // Update if necessary
        'amount': widget.totalPrice,
        'flightId': flightId,
        'bookingRequestDTO': {
          'flightId': flightId,
          'bookerFullName': contactDetails['fullName'],
          'bookerEmail': contactDetails['email'],
          'bookerPersonalId': contactDetails['personalId'],
          'userId': 0, // Update if necessary
          'bookingDate': DateTime.now().toIso8601String(),
          'passengers': passengerDetails,
          'seatNumber': passengerDetails.map((p) => p['seatNumber']).toList()
        }
      }),
    );

    if (response.statusCode == 200) {
      print('Payment created successfully');
    } else {
      throw Exception('Failed to create payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Thông tin hành khách', style: kLableSize20w700White),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5FA),
      body: Stack(fit: StackFit.expand, children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const InfoGuestWidget(),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Thông tin liên hệ',
                        style: kLableSize20w700Black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InputTextComponent(
                              label: 'Tên',
                              name: '',
                              hinttext: 'VD: Trung Tinh',
                              onChanged: (value) {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InputTextComponent(
                              label: 'Số điện thoại',
                              name: '',
                              hinttext: '0704408389',
                              onChanged: (value) {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InputTextComponent(
                              label: 'Email',
                              name: '',
                              hinttext: 'trungtinhh1620@gmail.com',
                              onChanged: (value) {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: _buildPassengerInfoFields(),
              )
            ],
          )),
        )
      ]),
      bottomNavigationBar: Container(
        color: AppColors.white,
        height: 130.0, // Adjust the height as needed
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng số tiền', style: kLableSize18w700Black),
                Text(
                  '${widget.totalPrice} đ',
                  style: kLableSize18w500Bule,
                ),
              ],
            ),
            ButtonBlue(
              des: 'Tiếp tục',
              onPress: _submitDetails,
            ),
          ],
        ),
      ),
    );
  }
}
