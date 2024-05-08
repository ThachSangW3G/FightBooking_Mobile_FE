import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/ticket_details_screen.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/ticket/flight_ticket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketScreenWidget extends StatelessWidget {
  final List<Map<String, dynamic>> flightTickets = [
    {
      'status': 'Xuất vé thành công',
      'depart': 'Hồ Chí Minh',
      'arrive': 'Hà Nội',
      'departCode': 'SGN',
      'arriveCode': 'HAN',
      'totalPrice': 15000000,
      'ticketId': '187439124'
    },
    {
      'status': 'Xuất vé thất bại',
      'depart': 'Hồ Chí Minh',
      'arrive': 'Hà Nội',
      'departCode': 'SGN',
      'arriveCode': 'HAN',
      'totalPrice': 15000000,
      'ticketId': '187439124'
    },
    {
      'status': 'Đang giữ chỗ',
      'depart': 'Hồ Chí Minh',
      'arrive': 'Hà Nội',
      'departCode': 'SGN',
      'arriveCode': 'HAN',
      'totalPrice': 15000000,
      'ticketId': '187439124'
    },
    {
      'status': 'Xuất vé thành công',
      'depart': 'Hồ Chí Minh',
      'arrive': 'Hà Nội',
      'departCode': 'SGN',
      'arriveCode': 'HAN',
      'totalPrice': 15000000,
      'ticketId': '187439124'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: Image.asset('assets/icons/nav_back_icon.png'),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Vé của tôi',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        color: AppColors.theme,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
              _buildFlightTicket(), // Danh sách chuyến bay
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightTicket() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
        const Padding(
          padding: EdgeInsets.only(bottom: 2.0), // Add padding bottom
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tìm kiếm vé',
                style: TextStyle(
                  fontSize: 18, // Increase font size for "Chi tiết đơn hàng"
                  fontWeight: FontWeight.bold, // Make it bold
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: flightTickets.length,
          itemBuilder: (context, index) {
            final flightTicket = flightTickets[index];
            return InkWell(
              onTap: () {
                // Chuyển đến màn hình chi tiết khi người dùng chọn một vé

                Get.to(
                  () => TicketDetailsScreen(
                    ticketId: flightTicket['ticketId'],
                    status: flightTicket['status'],
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0), // Add padding bottom
                child: FlightTicketWidget(
                  // Truyền dữ liệu chuyến bay vào FlightInfoWidget
                  status: flightTicket['status'],
                  depart: flightTicket['depart'],
                  departCode: flightTicket['departCode'],
                  arrive: flightTicket['arrive'],
                  arriveCode: flightTicket['arriveCode'],
                  totalPrice: flightTicket['totalPrice'],
                  id: flightTicket['ticketId'],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
