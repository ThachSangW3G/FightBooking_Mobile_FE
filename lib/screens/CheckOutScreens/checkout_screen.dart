import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/widgets/flight_info_widget.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<Map<String, dynamic>> flights = [
    {
      'flightName': 'Hồ Chí Minh - Hà Nội',
      'airlineLogo':
          'https://careerfinder.vn/wp-content/uploads/2020/05/vietnam-airline-logo.jpg',
      'airlineName': 'Vietnam Airlines',
      'airlineNumber': 'VN123',
      'seatClass': 'Economy',
      'depart': 'HAN',
      'arrive': 'SGN',
      'departTime': '08:00, 04/08/2024',
      'arriveTime': '10:00, 08/08/2024',
      'totalFlight': '2h 04m',
    },
    {
      'flightName': 'Hồ Chí Minh - Hà Nội',
      'airlineLogo':
          'https://careerfinder.vn/wp-content/uploads/2020/05/vietnam-airline-logo.jpg',
      'airlineName': 'Vietnam Airlines',
      'airlineNumber': 'VN123',
      'seatClass': 'Economy',
      'depart': 'HAN',
      'arrive': 'SGN',
      'departTime': '08:00, 04/08/2024',
      'arriveTime': '10:00, 08/08/2024',
      'totalFlight': '2h 04m',
    },
    {
      'flightName': 'Hồ Chí Minh - Hà Nội',
      'airlineLogo':
          'https://careerfinder.vn/wp-content/uploads/2020/05/vietnam-airline-logo.jpg',
      'airlineName': 'Vietnam Airlines',
      'airlineNumber': 'VN123',
      'seatClass': 'Economy',
      'depart': 'HAN',
      'arrive': 'SGN',
      'departTime': '08:00, 04/08/2024',
      'arriveTime': '10:00, 08/08/2024',
      'totalFlight': '2h 04m',
    }
    // Add more flight data here if needed
  ];
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: Image.asset('assets/icons/nav_back_icon.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thông tin thanh toán',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
              _buildFlightList(), // Danh sách chuyến bay
              const SizedBox(height: 10),
              const Text(
                'Chi tiết giá',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Thêm danh sách các mục chi tiết giá ở đây
              const SizedBox(height: 10),
              const Text(
                'Thông tin khách hàng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Thêm danh sách thông tin khách hàng ở đây
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // Add padding bottom
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi tiết đơn hàng',
                style: TextStyle(
                  fontSize: 18, // Increase font size for "Chi tiết đơn hàng"
                  fontWeight: FontWeight.bold, // Make it bold
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0), // Add padding bottom
                child: FlightInfoWidget(
                  // Truyền dữ liệu chuyến bay vào FlightInfoWidget
                  flightName: flight['flightName'],
                  airlineLogo: flight['airlineLogo'],
                  airlineName: flight['airlineName'],
                  airlineNumber: flight['airlineNumber'],
                  seatClass: flight['seatClass'],
                  depart: flight['depart'],
                  arrive: flight['arrive'],
                  departTime: flight['departTime'],
                  arriveTime: flight['arriveTime'],
                  totalFlight: flight['totalFlight'],
                ),
              );
            },
          ),
      ],
    );
  }
}
