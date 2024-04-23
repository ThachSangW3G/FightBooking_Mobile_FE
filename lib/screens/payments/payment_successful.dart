import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flutter/material.dart';

class PaymentSuccessfulWidget extends StatelessWidget {
  const PaymentSuccessfulWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AppColors.dodger,
            radius: 48.0,
            child: Icon(
              Icons.check,
              size: 48.0,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Thanh toán thành công',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Tham khảo hàng trăm chuyến bay khác trên Traveloka ngay bây giờ!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DefaultScreen()),
                      );
                    },
                    child: Text(
                      'Trang chủ',
                      style: TextStyle(color: AppColors.dodger),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.dodger,
                        width: 2.0,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // Khoảng cách giữa hai nút
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle navigation to ticket details
                    },
                    child: Text(
                      'Chi tiết vé',
                      style: TextStyle(color: AppColors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dodger,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      textStyle: TextStyle(fontSize: 20.0),
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
