import 'dart:convert';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/passenger_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/user_controller.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airline.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/airport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_screen.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_passenger_contact_widget.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_passenger_info_widget.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_price_widget.dart';
import 'package:flightbooking_mobile_fe/controllers/booking_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flightbooking_mobile_fe/models/Thuongle/flight.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/plane.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/regulation.dart';
import 'package:flightbooking_mobile_fe/services/flight_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final BookingController bookingController = Get.find<BookingController>();
  final PassengerController passengerController =
      Get.find<PassengerController>();
  final UserController userController = Get.find<UserController>();
  bool isExpandedDetails = true;
  bool isExpandedPriceDetails = true;
  bool isExpandedPassenger = true;

  Future<Flight> fetchFlightById(int flightId) async {
    final response = await http.get(Uri.parse(
        'https://flightbookingbe-production.up.railway.app/flight/get-flight-by-id?id=$flightId'));
    if (response.statusCode == 200) {
      return Flight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load flight data');
    }
  }

  Future<Map<String, dynamic>> fetchAdditionalFlightData(int flightId) async {
    final flight = await fetchFlightById(flightId);

    final airlineFuture = fetchAirlineByPlaneId(flight.planeId);
    final planeFuture = fetchPlaneNumberByPlaneId(flight.planeId);
    final regulationFuture = fetchRegulationByAirlineId((await airlineFuture)
        .id); // Đảm bảo rằng airlineFuture đã hoàn thành trước khi dùng kết quả của nó
    final departureAirportFuture = fetchAirportById(flight.departureAirportId);
    final arrivalAirportFuture = fetchAirportById(flight.arrivalAirportId);

    final results = await Future.wait([
      airlineFuture,
      planeFuture,
      regulationFuture,
      departureAirportFuture,
      arrivalAirportFuture,
    ]);

    return {
      'flight': flight,
      'airline': results[0],
      'plane': results[1],
      'regulation': results[2],
      'departureAirport': results[3],
      'arrivalAirport': results[4],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Thông tin thanh toán', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              _buildFlightList(),
              Divider(),
              const SizedBox(height: 0),
              _buildPriceList(),
              Divider(),
              const SizedBox(height: 0),
              _buildPassengerList(),
              Divider(),
              const SizedBox(height: 0),
              _buildPassengerContact(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildTotalSection(),
    );
  }

  Widget _buildFlightList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi tiết đơn hàng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpandedDetails = !isExpandedDetails;
                  });
                },
                icon: Icon(isExpandedDetails
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        if (isExpandedDetails)
          Column(
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: fetchAdditionalFlightData(
                    bookingController.departureFlightId.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final additionalData = snapshot.data!;
                    return FlightInfoWidget(
                      flightName: 'Chuyến đi',
                      airlineLogo: additionalData['airline'].logoUrl,
                      airlineName: additionalData['airline'].airlineName,
                      airlineNumber: additionalData['plane'].planeNumber,
                      seatClass: 'Economy',
                      depart: additionalData['departureAirport'].iataCode,
                      arrive: additionalData['arrivalAirport'].iataCode,
                      departTime: DateTime.fromMillisecondsSinceEpoch(
                              additionalData['flight'].departureDate)
                          .toString(),
                      arriveTime: DateTime.fromMillisecondsSinceEpoch(
                              additionalData['flight'].arrivalDate)
                          .toString(),
                      totalFlight: additionalData['flight'].duration.toString(),
                    );
                  } else {
                    return Center(child: Text('No data'));
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (bookingController.returnFlightId.value != 0)
                FutureBuilder<Map<String, dynamic>>(
                  future: fetchAdditionalFlightData(
                      bookingController.returnFlightId.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final additionalData = snapshot.data!;
                      return FlightInfoWidget(
                        flightName: 'Chuyến về',
                        airlineLogo: additionalData['airline'].logoUrl,
                        airlineName: additionalData['airline'].airlineName,
                        airlineNumber: additionalData['plane'].planeNumber,
                        seatClass: 'Economy',
                        depart: additionalData['departureAirport'].iataCode,
                        arrive: additionalData['arrivalAirport'].iataCode,
                        departTime: DateTime.fromMillisecondsSinceEpoch(
                                additionalData['flight'].departureDate)
                            .toString(),
                        arriveTime: DateTime.fromMillisecondsSinceEpoch(
                                additionalData['flight'].arrivalDate)
                            .toString(),
                        totalFlight:
                            additionalData['flight'].duration.toString(),
                      );
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildPriceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi tiết giá',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpandedPriceDetails = !isExpandedPriceDetails;
                  });
                },
                icon: Icon(isExpandedPriceDetails
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        if (isExpandedPriceDetails)
          FlightPriceDetailsWidget(
            adults: passengerController.adult.value,
            children: passengerController.children.value,
            infants: passengerController.babe.value,
            totalPrice: bookingController.totalPrice.value,
          ),
      ],
    );
  }

  double _calculateTotalPrice(List<Map<String, String>> passengers) {
    double total = 0.0;
    for (var passenger in passengers) {
      total += double.parse(passenger['price'] ?? '0');
    }
    return total;
  }

  Widget _buildPassengerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thông tin hành khách',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpandedPassenger = !isExpandedPassenger;
                  });
                },
                icon: Icon(isExpandedPassenger
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        if (isExpandedPassenger)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: bookingController.passengerDetails.length,
            itemBuilder: (context, index) {
              final passenger = bookingController.passengerDetails[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: FlightPassengerInfoWidget(
                  passengerName: passenger['fullName']!,
                  passengerType: passenger['personalId']!,
                  // Additional fields can be added here
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildPassengerContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlightPassengerContactWidget(
          contactName: bookingController.contactDetails['fullName']!,
          contactPhoneNumber: bookingController.contactDetails['phone']!,
          contactEmail: bookingController.contactDetails['email']!,
          // Additional fields can be added here
        ),
      ],
    );
  }

  bool isChecked = false;
  Widget _buildPaymentDialog(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Số tiền phải thanh toán',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Divider(),
                Text(
                  '${bookingController.totalPrice.value} đ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    Flexible(
                      child: Text(
                        'Tôi đã đọc, hiểu và đồng ý Điều kiện giá vé, Điều kiện vận chuyển, Điều kiện đặt vé trực tuyến, Chính sách bảo mật và các nội dung khác',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isChecked ? Colors.blue : Colors.red,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isChecked
                      ? () {
                          Get.to(() => PaymentScreen(
                                flightDetails: [
                                  {
                                    "flightId": bookingController
                                        .departureFlightId.value,
                                    "bookerFullName": bookingController
                                        .contactDetails['fullName'],
                                    "bookerEmail": bookingController
                                        .contactDetails['email'],
                                    "bookerPhoneNumber": bookingController
                                        .contactDetails['phone'],
                                    "userId": userController.currentUser.value!
                                        .id, // Update this with actual user ID
                                    "bookingDate":
                                        DateTime.now().toIso8601String(),
                                    "passengers": bookingController
                                        .departurePassengerDetails,
                                  },
                                  if (bookingController.returnFlightId.value !=
                                      0)
                                    {
                                      "flightId": bookingController
                                          .returnFlightId.value,
                                      "bookerFullName": bookingController
                                          .contactDetails['fullName'],
                                      "bookerEmail": bookingController
                                          .contactDetails['email'],
                                      "bookerPhoneNumber": bookingController
                                          .contactDetails['phone'],
                                      "userId":
                                          13, // Update this with actual user ID
                                      "bookingDate":
                                          DateTime.now().toIso8601String(),
                                      "passengers": bookingController
                                          .returnPassengerDetails,
                                    }
                                ],
                                passengerDetails:
                                    bookingController.passengerDetails,
                                totalAmount:
                                    bookingController.totalPrice.toDouble(),
                              ));
                        }
                      : null,
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${bookingController.totalPrice.value} đ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => _buildPaymentDialog(context),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dodger,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                minimumSize: Size(double.infinity, 40),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(
                'Thanh toán',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
