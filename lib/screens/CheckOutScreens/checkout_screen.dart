import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_price_widget.dart';
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
  final List<Map<String, dynamic>> flightPrice = [
    {
      'adults': 2,
      'children': 1,
      'infants': 1,
      'priceAdult': 100,
      'priceChild': 80,
      'priceInfant': 40,
      'totalPrice': 220
    }
  ];
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
              _buildFlightList(), // Danh sách chuyến bay
              Divider(),
              const SizedBox(height: 0),
              _buildPriceList(),
              Divider(),
              // Thêm danh sách các mục chi tiết giá ở đây
              const SizedBox(height: 0),
              _buildPassengerList(),
              Divider(),
              // Thêm danh sách thông tin khách hàng ở đây
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
        const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0), // Add padding bottom
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0), // Add padding bottom
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

  Widget _buildPriceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0), // Add padding bottom
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chi tiết giá',
                style: TextStyle(
                  fontSize: 18, // Increase font size for "Chi tiết đơn hàng"
                  fontWeight: FontWeight.bold, // Make it bold
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: flightPrice.length,
            itemBuilder: (context, index) {
              final flightPrices = flightPrice[index];
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0), // Add padding bottom
                child: FlightPriceDetailsWidget(
                  // Truyền dữ liệu chuyến bay vào FlightInfoWidget
                  adults: flightPrices['adults'],
                  children: flightPrices['children'],
                  infants: flightPrices['infants'],
                  priceAdult: flightPrices['priceAdult'],
                  priceChild: flightPrices['priceChild'],
                  priceInfant: flightPrices['priceInfant'],
                  totalPrice: flightPrices['totalPrice'],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildPassengerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0), // Add padding bottom
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thông tin hành khách',
                style: TextStyle(
                  fontSize: 18, // Increase font size for "Chi tiết đơn hàng"
                  fontWeight: FontWeight.bold, // Make it bold
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
            itemCount: flightPrice.length,
            itemBuilder: (context, index) {
              final flightPrices = flightPrice[index];
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0), // Add padding bottom
                child: FlightPriceDetailsWidget(
                  // Truyền dữ liệu chuyến bay vào FlightInfoWidget
                  adults: flightPrices['adults'],
                  children: flightPrices['children'],
                  infants: flightPrices['infants'],
                  priceAdult: flightPrices['priceAdult'],
                  priceChild: flightPrices['priceChild'],
                  priceInfant: flightPrices['priceInfant'],
                  totalPrice: flightPrices['totalPrice'],
                ),
              );
            },
          ),
      ],
    );
  }
}

Widget _buildTotalSection() {
  return Container(
    color: Colors.white, // Màu nền cho container
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
                '12.400.000 đ', // Cập nhật giá tiền đúng
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
          SizedBox(height: 15), // Khoảng cách giữa text và button
          ElevatedButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút thanh toán
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dodger, // Màu nền của nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bo tròn góc của nút
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10), // Đệm dọc lớn hơn để nút cao hơn
              minimumSize: Size(double.infinity,
                  56), // Chiều dài tối thiểu của nút (double.infinity sẽ làm nút dài ra cùng với chiều rộng của parent widget)
              textStyle: TextStyle(fontSize: 18), // Kích thước chữ của nút
            ),
            child: Text(
              'Thanh toán',
              style: TextStyle(color: Colors.white), // Màu chữ của nút
            ),
          ),
        ],
      ),
    ),
  );
}
