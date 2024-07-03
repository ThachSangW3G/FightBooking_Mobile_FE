import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/components/info_guest/input_text.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/controllers/booking_controller.dart';

class InfoGuestScreen extends StatefulWidget {
  final int numPassengers;
  final double totalPrice;
  final int departureFlightId;
  final int? returnFlightId;
  final List<String> selectedDepartureSeats;
  final List<String>? selectedReturnSeats;

  const InfoGuestScreen({
    super.key,
    required this.numPassengers,
    required this.totalPrice,
    required this.departureFlightId,
    this.returnFlightId,
    required this.selectedDepartureSeats,
    this.selectedReturnSeats,
  });

  @override
  State<InfoGuestScreen> createState() => _InfoGuestScreenState();
}

class _InfoGuestScreenState extends State<InfoGuestScreen> {
  final List<Map<String, String>> departurePassengerDetails = [];
  final List<Map<String, String>> returnPassengerDetails = [];
  final BookingController bookingController = Get.put(BookingController());

  final Map<String, String> contactDetails = {
    'fullName': '',
    'phone': '',
    'email': ''
  };

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numPassengers; i++) {
      departurePassengerDetails.add({
        'fullName': '',
        'personalId': '',
        'email': '',
        'seatNumber': widget.selectedDepartureSeats[i],
      });

      if (widget.returnFlightId != null && widget.selectedReturnSeats != null) {
        returnPassengerDetails.add({
          'fullName': '',
          'personalId': '',
          'email': '',
          'seatNumber': widget.selectedReturnSeats![i],
        });
      }
    }
  }

  List<Widget> _buildPassengerInfoFields(
      List<Map<String, String>> passengerDetails, String flightType) {
    List<Widget> fields = [];
    for (int i = 0; i < passengerDetails.length; i++) {
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
              Text(
                  'Thông tin hành khách ${i + 1} (Ghế: ${passengerDetails[i]['seatNumber']}) - $flightType',
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
            ],
          ),
        ),
      );
    }
    return fields;
  }

  void _submitDetails() {
    bookingController.setBookingDetails(
      departureId: widget.departureFlightId,
      returnId: widget.returnFlightId,
      price: widget.totalPrice,
      contact: contactDetails,
      departurePassengerDetails: departurePassengerDetails,
      returnPassengerDetails: returnPassengerDetails,
      passengers: departurePassengerDetails + returnPassengerDetails,
      departureSeats: widget.selectedDepartureSeats,
      returnSeats: widget.selectedReturnSeats,
    );

    Get.to(() => CheckoutScreen());
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
                              onChanged: (value) {
                                setState(() {
                                  contactDetails['fullName'] = value;
                                });
                              }),
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
                              onChanged: (value) {
                                setState(() {
                                  contactDetails['phone'] = value;
                                });
                              }),
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
                              onChanged: (value) {
                                setState(() {
                                  contactDetails['email'] = value;
                                });
                              }),
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
                children: _buildPassengerInfoFields(
                    departurePassengerDetails, 'Lượt đi'),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.returnFlightId != null
                  ? Column(
                      children: _buildPassengerInfoFields(
                          returnPassengerDetails, 'Lượt về'),
                    )
                  : Container(),
            ],
          )),
        )
      ]),
      bottomNavigationBar: Container(
        color: AppColors.white,
        height: 130.0,
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
