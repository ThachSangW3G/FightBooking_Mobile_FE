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
  String? selectedCard;
  bool isChecked = false;

  // Controllers for card information
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final PaymentController paymentController = PaymentController(
      baseUrl:
          'http://localhost:7050/payment/register-card'); // Replace with your actual base URL

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
              'Thẻ Visa, Master, JCB',
              selectedPaymentMethod == 'Visa' ? savedCardOptions() : null,
            ),
            paymentOption(
              'VNPay',
              'assets/logo/vnpay.png', // Path to VNPay logo image
              'Thanh toán bằng VNPay',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod != null &&
                    selectedPaymentMethod!.isNotEmpty) {
                  if (selectedPaymentMethod == 'Visa' &&
                      (selectedCard != null || selectedCard == 'new_card')) {
                    if (selectedCard == 'new_card') {
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
                                onPressed: () {
                                  // Process adding new card here
                                  Navigator.of(context).pop();
                                },
                                child: Text('Lưu'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      processVisaPayment();
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
          Image.asset('assets/logo/visa.png',
              width: 40, height: 24), // Replace with card brand image
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
                          onPressed: () {
                            // Process adding new card here
                            Navigator.of(context).pop();
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
        TextField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: 'MM / YY',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CVC',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
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
