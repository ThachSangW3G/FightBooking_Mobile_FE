import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/controllers/payment_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  String? selectedCard;
  bool isChecked = false;

  final PaymentController paymentController = PaymentController(
      baseUrl:
          'http://192.168.1.100:7050'); // Replace with your actual base URL

  List<String> savedCards = [
    '**** **** **** 1234',
    '**** **** **** 5678'
  ]; // Dummy saved cards

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        "pk_test_51OVwerA7WrEjctnX9STvulzywtvSiHbBfwpWtPz1qUisHRlxGoqeYEsezmX3wub802xxdEyo6N65w2zLu77HLP3200k4IHYlWU"; // Replace with your Stripe publishable key
  }

  Future<void> createCustomerAndSetupIntent(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${paymentController.baseUrl}/payment/create-customer?email=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final customerId = response.body;

        final setupIntentResponse = await http.post(
          Uri.parse(
              '${paymentController.baseUrl}/payment/create-setup-intent?customerId=$customerId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (setupIntentResponse.statusCode == 200) {
          final setupIntentData = jsonDecode(setupIntentResponse.body);
          final clientSecret = setupIntentData['clientSecret'];

          // Display the card form to the user and collect card details
          await Stripe.instance.confirmSetupIntent(
            paymentIntentClientSecret: clientSecret,
            params: PaymentMethodParams.card(
              paymentMethodData: PaymentMethodData(
                billingDetails: BillingDetails(
                  email:
                      'ledangthuong2003@gmail.com', // Replace with the user's actual email
                  phone:
                      '+84987654321', // Replace with the user's actual phone number
                ),
              ),
            ),
          );

          // Handle successful card setup
          print('Card setup successful');
        } else {
          throw Exception('Failed to create setup intent');
        }
      } else {
        throw Exception('Failed to create customer');
      }
    } catch (e) {
      print('Error: $e');
    }
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
              'assets/logo/visa.png',
              'Thẻ Visa, Master, JCB',
              selectedPaymentMethod == 'Visa' ? savedCardOptions() : null,
            ),
            paymentOption(
              'VNPay',
              'assets/logo/vnpay.png',
              'Thanh toán bằng VNPay',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedPaymentMethod != null &&
                    selectedPaymentMethod!.isNotEmpty) {
                  if (selectedPaymentMethod == 'Visa' &&
                      (selectedCard != null || selectedCard == 'new_card')) {
                    if (selectedCard == 'new_card') {
                      // Assume email is available, you can replace with the actual email
                      await createCustomerAndSetupIntent(
                          'ledangthuong2003@gmail.com');
                    } else {
                      await processVisaPayment();
                    }
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

  Widget paymentOption(String value, String imagePath, String title,
      [Widget? child]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title),
          leading: Radio(
            value: value,
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value as String?;
                selectedCard = null;
              });
            },
          ),
          trailing: Image.asset(imagePath, width: 100, height: 50),
        ),
        if (child != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: child,
          ),
      ],
    );
  }

  Widget savedCardOptions() {
    return Column(
      children: [
        for (String card in savedCards) savedCardItem(card),
        newCardOption(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Golobe không sử dụng thông tin thẻ của khách hàng cho mục đích nào khác',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget savedCardItem(String card) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: card,
            groupValue: selectedCard,
            onChanged: (value) {
              setState(() {
                selectedCard = value;
              });
            },
          ),
          Image.asset('assets/logo/visa.png', width: 40, height: 24),
          SizedBox(width: 8),
          Expanded(child: Text(card)),
          TextButton(
            onPressed: () {
              // Handle card removal logic here
            },
            child: Text('Xóa thẻ', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget newCardOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: 'new_card',
            groupValue: selectedCard,
            onChanged: (value) {
              setState(() {
                selectedCard = value;
              });
              if (value == 'new_card') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm thẻ mới'),
                      content: newCardForm(),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final success = await registerNewCard();
                            if (success) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Lưu'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          Expanded(child: Text('Thanh toán bằng thẻ mới')),
        ],
      ),
    );
  }

  Widget newCardForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CardFormField(),
      ],
    );
  }

  Future<bool> registerNewCard() async {
    try {
      // Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email:
                  'ledangthuongsp@gmail.com', // Replace with the user's actual email
              phone:
                  '+84987654321', // Replace with the user's actual phone number
            ),
          ),
        ),
      );

      if (paymentMethod.card != null && paymentMethod.card!.last4 != null) {
        // Prepare data for back-end
        final response = await paymentController.registerCard(
          username: 'thuongle', // Replace with actual username
          stripePaymentMethodId: paymentMethod.id,
          last4Digits: paymentMethod.card!.last4!,
          expiryDate:
              '${paymentMethod.card!.expMonth}/${paymentMethod.card!.expYear}',
        );

        if (response.statusCode == 200) {
          print('Card registered successfully');
          return true;
        } else {
          print('Failed to register card: ${response.body}');
          return false;
        }
      } else {
        print('Card information is incomplete');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<void> processVisaPayment() async {
    try {
      // Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email:
                  'ledangthuongsp@gmail.com', // Replace with the user's actual email
              phone:
                  '+84987654321', // Replace with the user's actual phone number
            ),
          ),
        ),
      );

      if (paymentMethod.card != null && paymentMethod.card!.last4 != null) {
        // Send PaymentMethod ID to your server to process the payment
        final response = await paymentController.registerCard(
          username: 'thuongle', // Replace with actual username
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
