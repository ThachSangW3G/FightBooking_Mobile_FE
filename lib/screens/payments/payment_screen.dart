import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/controllers/payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  bool isChecked = false;

  // Controllers for card information
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final PaymentController paymentController = PaymentController(
      baseUrl:
          'http://localhost:7050/payment/register-card'); // Replace with your actual base URL
  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        "pk_test_51OVwerA7WrEjctnX9STvulzywtvSiHbBfwpWtPz1qUisHRlxGoqeYEsezmX3wub802xxdEyo6N65w2zLu77HLP3200k4IHYlWU"; // Replace with your Stripe publishable key
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
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
            if (selectedPaymentMethod == 'Visa') cardDetailsForm(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod != null &&
                    selectedPaymentMethod!.isNotEmpty) {
                  if (selectedPaymentMethod == 'Visa') {
                    processVisaPayment();
                  } else {
                    Get.to(() => const PaymentSuccessfulWidget());
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Lựa chọn phương thức thanh toán'),
                        content:
                            Text('Vui lòng chọn một phương thức thanh toán.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Đóng'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Thanh toán'),
            ),
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
            selectedPaymentMethod = value as String?;
          });
        },
      ),
      trailing: Image.asset(imagePath, width: 100, height: 50),
    );
  }

  Widget cardDetailsForm() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _cardNumberController,
          decoration: InputDecoration(
            labelText: 'Số thẻ',
          ),
        ),
        TextField(
          controller: _expiryDateController,
          decoration: InputDecoration(
            labelText: 'Ngày hết hạn (MM/YY)',
          ),
        ),
        TextField(
          controller: _cvvController,
          decoration: InputDecoration(
            labelText: 'CVV',
          ),
        ),
      ],
    );
  }

  void processVisaPayment() async {
    try {
      // Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email:
                  'email@example.com', // Replace with the user's actual email
              phone:
                  '+84987654321', // Replace with the user's actual phone number
            ),
          ),
        ),
      );

      if (paymentMethod.card != null && paymentMethod.card!.last4 != null) {
        // Send PaymentMethod ID to your server to process the payment
        final response = await paymentController.registerCard(
          username: 'user-username', // Replace with actual username
          stripePaymentMethodId: paymentMethod.id,
          last4Digits: paymentMethod.card!.last4!,
          expiryDate:
              '${paymentMethod.card!.expMonth}/${paymentMethod.card!.expYear}',
        );

        if (response.statusCode == 200) {
          Get.to(() => const PaymentSuccessfulWidget());
        } else {
          // Handle error
          print('Failed to register card: ${response.body}');
        }
      } else {
        // Handle error
        print('Card information is incomplete');
      }
    } catch (e) {
      print(e);
    }
  }
}
