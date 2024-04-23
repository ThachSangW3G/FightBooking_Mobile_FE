import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/CheckOutScreens/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/PaymentScreens/payment_screen.dart';
import 'package:flightbooking_mobile_fe/screens/TicketScreens/export_ticket_screen.dart';
import 'package:flightbooking_mobile_fe/screens/TicketScreens/view_ticket_screen.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_info_widget.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_passenger_contact_widget.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_passenger_info_widget.dart';
import 'package:flightbooking_mobile_fe/widgets/checkout/flight_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TicketDetailsScreen extends StatefulWidget {
  final String ticketId;
  final String status;

  const TicketDetailsScreen({
    Key? key,
    required this.ticketId,
    required this.status,
  }) : super(key: key);

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
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

  final List<Map<String, dynamic>> flightPassenger = [
    {
      'name': 'NGUYEN VAN ANH',
      'type': 'Người lớn',
      // ví dụ thêm thông tin số ghế
      // Thêm các thông tin khác nếu cần
    },
    {
      'name': 'NGUYEN VAN BINH',
      'type': 'Người lớn',

      // Thêm các thông tin khác nếu cần
    },
    {
      'name': 'NGUYEN VAN HA',
      'type': 'Trẻ em',
      // Thêm các thông tin khác nếu cần
    },
    {
      'name': 'NGUYEN VAN NAM',
      'type': 'Em bé',
      // Thêm các thông tin khác nếu cần
    }
  ];
  final List<Map<String, dynamic>> passengerContact = [
    {
      'fullName': 'LE DANG THUONG',
      'phoneNumber': '0333333333',
      'email': 'ledangthuongsp@gmail.com'
    }
  ];
  // Dữ liệu mẫu cho card vé
  final FlightTicket sampleTicket = FlightTicket(
    departureAirport: 'SGN',
    arrivalAirport: 'HAN',
    departureCity: 'Hồ Chí Minh',
    arrivalCity: 'Hà Nội',
    departureDate: 'Dec 11, 2023',
    departureTime: '07:00 PM',
    seatClass: 'Economy',
    seatNumber: 'B4',
    barcodeData: '1234567890',
  );
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TicketScreenWidget()),
            );
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusWidget(widget.status),
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
              const SizedBox(height: 0),
              _buildPassengerContact(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
            itemCount: flightPassenger.length,
            itemBuilder: (context, index) {
              final flightPassengerInfo = flightPassenger[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 2), // Add padding bottom
                child: FlightPassengerInfoWidget(
                  passengerName: flightPassengerInfo['name'],
                  passengerType: flightPassengerInfo['type'],
                  // Thêm các trường thông tin khác nếu có
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: passengerContact.length,
          itemBuilder: (context, index) {
            final flightPassengerContact = passengerContact[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20), // Add padding bottom
              child: FlightPassengerContactWidget(
                contactName: flightPassengerContact['fullName'],
                contactPhoneNumber: flightPassengerContact['phoneNumber'],
                contactEmail: flightPassengerContact['email'],
                // Thêm các trường thông tin khác nếu có
              ),
            );
          },
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
                    color: Colors.blue, // Assuming AppColors.dodger is blue
                  ),
                ),
                Divider(),
                Text(
                  '12.400.000 đ', // Số tiền cần thanh toán
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Assuming AppColors.dodger is blue
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
                    backgroundColor: isChecked
                        ? Colors.blue
                        : Colors
                            .red, // Change button color based on checkbox state
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isChecked
                      ? () {
                          // Navigate to payment screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()),
                          );
                        }
                      : null, // Disable button if checkbox is unchecked
                  child: Text(
                    'Thanh toán',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => Navigator.of(context).pop(), // Đóng dialog
                  child: Icon(
                    Icons.close,
                    color: Colors.blue, // Assuming AppColors.dodger is blue
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusWidget(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getTextColor(status),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Xuất vé thành công':
        return Colors.lightGreen;
      case 'Đang giữ chỗ':
        return Colors.yellow;
      case 'Xuất vé thất bại':
        return Colors.red;
      default:
        return Colors.grey; // Màu mặc định nếu không phải 3 trạng thái trên
    }
  }

  Color _getTextColor(String status) {
    switch (status) {
      case 'Xuất vé thành công':
        return Colors.green[700]!; // Sử dụng mã màu đậm hơn
      case 'Đang giữ chỗ':
        return Colors.brown; // Hoặc màu nào đó phù hợp với thiết kế của bạn
      case 'Xuất vé thất bại':
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  Widget _buildBottomNavigationBar() {
    switch (widget.status) {
      case 'Xuất vé thành công':
        return _buildSuccessBottomNavigationBar();
      case 'Đang giữ chỗ':
        return _buildHoldBottomNavigationBar();
      case 'Xuất vé thất bại':
        return SizedBox.shrink(); // Không hiển thị gì cả
      default:
        return SizedBox.shrink(); // Trường hợp mặc định
    }
  }

  Widget _buildSuccessBottomNavigationBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                SelectableText(widget.ticketId), // Cho phép sao chép
                IconButton(
                  onPressed: () {
                    // Sao chép mã vé
                    Clipboard.setData(ClipboardData(text: widget.ticketId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã sao chép mã vé')),
                    );
                  },
                  icon: Icon(Icons.content_copy),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Chuyển đến màn hình xem vé
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportTicketWidget()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dodger, // Màu nút là màu xanh
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Padding của nút
              ),
              child: Text('Xem vé',
                  style: TextStyle(color: Colors.white)), // Màu chữ trắng
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldBottomNavigationBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Mở dialog hoặc chuyển đến màn hình thanh toán
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.dodger, // Màu nút là màu xanh
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Padding của nút
          ),
          child: Text('Thanh toán ngay',
              style: TextStyle(
                  color: Colors.white, fontSize: 14)), // Màu chữ trắng
        ),
      ),
    );
  }
}
