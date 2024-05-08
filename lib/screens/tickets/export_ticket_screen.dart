import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/ticket_details_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/view_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FlightTicket {
  final String departureAirport;
  final String arrivalAirport;
  final String departureCity;
  final String arrivalCity;
  final String departureDate;
  final String departureTime;
  final String seatClass;
  final String seatNumber;
  final String barcodeData;

  FlightTicket({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureDate,
    required this.departureTime,
    required this.seatClass,
    required this.seatNumber,
    required this.barcodeData,
  });
}

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

class ExportTicketWidget extends StatelessWidget {
  final GlobalKey repaintBoundaryKey = GlobalKey();
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
        actions: [
          IconButton(
            color: AppColors.white,
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Xử lý cho nút menu ở đây
            },
          ),
        ],
        title: const Text(
          'Vé của tôi',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // Thay Column bằng ListView để cuộn nếu cần
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(12.0), // Border radius cho ảnh
              child: Image.asset(
                'assets/images/airplane.jpg', // Thay đổi URL hình ảnh
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Thông tin vé

            RepaintBoundary(
              key: repaintBoundaryKey,
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(sampleTicket.departureAirport,
                              style: Theme.of(context).textTheme.headline5),
                          Icon(Icons.airplanemode_active, size: 24.0),
                          Text(sampleTicket.arrivalAirport,
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0), // Thêm Padding ở đây
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(sampleTicket.departureCity),
                            Text(sampleTicket.arrivalCity),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Departure date'),
                          Text(sampleTicket.departureDate),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Time'),
                          Text(sampleTicket.departureTime),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Class'),
                          Text(sampleTicket.seatClass),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Seat'),
                          Text(sampleTicket.seatNumber),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: sampleTicket.barcodeData,
                          width: 200,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16), // Khoảng cách giữa Card và các nút
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.file_download),
                label: Text('Download Ticket'),
                onPressed: () {
                  // Code để tải vé dưới dạng ảnh
                  _downloadTicket(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadTicket(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Đảm bảo rằng bạn đã xin quyền ghi vào bộ nhớ. (Ví dụ sử dụng plugin permission_handler)

      // Lưu hình ảnh xuống thiết bị
      final result =
          await ImageGallerySaver.saveImage(pngBytes, name: "ticket");
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ticket downloaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download ticket')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
