import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            paymentOption(
              'Visa',
              'assets/logo/visa.png', // Path to Visa logo image
              'Thanh toán bằng Visa',
            ),
            paymentOption(
              'VNPay',
              'assets/logo/vnpay.png', // Path to VNPay logo image
              'Thanh toán bằng VNPay',
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ButtonBlue(
                  des: 'Thanh toán',
                  onPress: () {
                    if (selectedPaymentMethod != null &&
                        selectedPaymentMethod!.isNotEmpty) {
                      Get.to(() => const PaymentSuccessfulWidget());
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('Lựa chọn phương thức thanh toán'),
                            content: const Text(
                                'Vui lòng chọn một phương thức thanh toán.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Đóng'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
            )

            // ElevatedButton(
            //   onPressed: () {
            //     if (selectedPaymentMethod != null &&
            //         selectedPaymentMethod!.isNotEmpty) {
            //       Get.to(() => const PaymentSuccessfulWidget());
            //     } else {
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text('Lựa chọn phương thức thanh toán'),
            //             content:
            //                 Text('Vui lòng chọn một phương thức thanh toán.'),
            //             actions: <Widget>[
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pop();
            //                 },
            //                 child: Text('Đóng'),
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     }
            //   },
            //   child: Text('Thanh toán'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget paymentOption(String value, String imagePath, String title) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: value,
        groupValue: selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
      ),
      trailing: Image.asset(imagePath, width: 100, height: 50),
    );
  }
}
