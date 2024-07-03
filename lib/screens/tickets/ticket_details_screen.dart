import 'dart:convert';

import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/ticket_detail.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_passenger_contact_widget.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_passenger_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TicketDetailsScreen extends StatefulWidget {
  final int bookingId;

  const TicketDetailsScreen({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  Future<TicketDetailResponse> fetchTicketDetailById(int bookingId) async {
    final response = await http.get(Uri.parse(
        'https://flightbookingbe-production.up.railway.app/booking/get-ticket-detail-by-booking-id?bookingId=$bookingId'));

    if (response.statusCode == 200) {
      return TicketDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load ticket details');
    }
  }

  Future<Map<String, dynamic>> fetchTicketDetails() async {
    final ticketDetail = await fetchTicketDetailById(widget.bookingId);
    return {
      'ticketDetail': ticketDetail,
      // Add more fetched details if necessary
    };
  }

  bool isExpandedDetails = true;
  bool isExpandedPriceDetails = true;
  bool isExpandedPassenger = true;
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
        title: Text('Thông tin chi tiết vé', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTicketDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final ticketDetail = data['ticketDetail'];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildFlightInfo(ticketDetail),
                  Divider(),
                  const SizedBox(height: 10),
                  _buildPassengerList(ticketDetail),
                  Divider(),
                  const SizedBox(height: 10),
                  _buildContactInfo(ticketDetail),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildFlightInfo(TicketDetailResponse ticketDetail) {
    return FlightInfoWidget(
      flightName: 'Đã đặt',
      airlineLogo: ticketDetail.airlineLogoUrl,
      airlineName: ticketDetail.airlineName,
      airlineNumber: ticketDetail.planeNumber,
      seatClass: 'Economy',
      depart: ticketDetail.iataDepartureCode,
      arrive: ticketDetail.iataArrivalCode,
      departTime:
          DateTime.fromMillisecondsSinceEpoch(ticketDetail.departureDate)
              .toString(),
      arriveTime: DateTime.fromMillisecondsSinceEpoch(ticketDetail.arrivalDate)
          .toString(),
      totalFlight: '2',
    );
  }

  Widget _buildPassengerList(TicketDetailResponse ticketDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thông tin hành khách',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...ticketDetail.passengerDTOList.map((passenger) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: FlightPassengerInfoWidget(
              passengerName: passenger.fullName,
              passengerType: passenger.personalId,
              // Add more fields if necessary
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildContactInfo(TicketDetailResponse ticketDetail) {
    return FlightPassengerContactWidget(
      contactName: ticketDetail.bookerFullName,
      contactPhoneNumber: ticketDetail.bookerPhoneNumber,
      contactEmail: ticketDetail.bookerEmail,
    );
  }
}
