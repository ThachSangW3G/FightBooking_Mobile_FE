import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/bottom_nav/bottom_nav.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flightbooking_mobile_fe/screens/home/home_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/ticket_details_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/view_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessfulWidget extends StatelessWidget {
  const PaymentSuccessfulWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const CircleAvatar(
            backgroundColor: AppColors.dodger,
            radius: 48.0,
            child: Icon(
              Icons.check,
              size: 48.0,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Thanh toán thành công',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Tham khảo hàng trăm chuyến bay khác trên Traveloka ngay bây giờ!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.off(() => const BottomNavigation());
                    },
                    child: const Text(
                      'Trang chủ',
                      style: TextStyle(color: AppColors.dodger),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.dodger,
                        width: 2.0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0), // Khoảng cách giữa hai nút
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => TicketScreenWidget());
                    },
                    child: const Text(
                      'Chi tiết vé',
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dodger,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
