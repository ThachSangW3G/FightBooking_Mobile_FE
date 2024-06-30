import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';

import 'package:flightbooking_mobile_fe/components/payments/new_card_option.dart';
import 'package:flightbooking_mobile_fe/components/payments/payment_option.dart';
import 'package:flightbooking_mobile_fe/components/payments/saved_card_item.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';

import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/services/stripe_service.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  String? selectedCard;
  bool isChecked = false;
  bool _isProcessing = false;
  String username = "thuongsp";
  String email = "ledangthuongsp@gmail.com";

  final StripeService stripeService = StripeService(
      baseUrl:
          'https://flightbookingbe-production.up.railway.app'); // Replace with your actual IP address

  List<Map<String, dynamic>> savedCards = [];

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        "pk_test_51OVwerA7WrEjctnX9STvulzywtvSiHbBfwpWtPz1qUisHRlxGoqeYEsezmX3wub802xxdEyo6N65w2zLu77HLP3200k4IHYlWU"; // Replace with your Stripe publishable key

    fetchSavedCards();
  }

  Future<void> fetchSavedCards() async {
    final cards = await stripeService.fetchSavedCards(email);
    setState(() {
      savedCards = cards;
    });
  }

  Future<void> chargeSavedCard(
      String email, String paymentMethodId, double amount) async {
    try {
      await stripeService.chargeSavedCard(email, paymentMethodId, amount);
      Get.off(() => const PaymentSuccessfulWidget());
    } catch (e) {
      print('Error during chargeSavedCard: $e'); // In ra lỗi để kiểm tra
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to charge saved card. Please try again.')),
      );
    }
  }

  Future<void> createCustomerAndSetupIntent() async {
    try {
      final newCard =
          await stripeService.createCustomerAndSetupIntent(email, username);
      setState(() {
        savedCards.add(newCard);
        selectedCard = newCard['stripePaymentMethodId'];
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(
          'Error during createCustomerAndSetupIntent: $e'); // In ra lỗi để kiểm tra
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set up the card. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Thanh toán', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PaymentOption(
                  value: 'Visa',
                  imagePath: 'assets/logo/visa.png',
                  title: 'Thẻ Visa, Master, JCB',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                      selectedCard = null;
                    });
                  },
                  child: selectedPaymentMethod == 'Visa'
                      ? savedCardOptions()
                      : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedPaymentMethod != null &&
                        selectedPaymentMethod!.isNotEmpty) {
                      if (selectedPaymentMethod == 'Visa' &&
                          (selectedCard != null ||
                              selectedCard == 'new_card')) {
                        if (selectedCard == 'new_card') {
                          await createCustomerAndSetupIntent();
                        } else {
                          await chargeSavedCard(email, selectedCard!,
                              10.0); // Thanh toán 10 đô la Mỹ
                        }
                      } else {
                        Get.off(() => const PaymentSuccessfulWidget());
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Lựa chọn phương thức thanh toán'),
                            content: Text(
                                'Vui lòng chọn một phương thức thanh toán.'),
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
        ],
      ),
    );
  }

  Widget savedCardOptions() {
    return Column(
      children: [
        for (var card in savedCards)
          SavedCardItem(
            paymentMethodId: card['stripePaymentMethodId']!,
            cardLast4: card['cardLast4']!,
            cardBrand: card['cardBrand']!,
            selectedCard: selectedCard,
            onChanged: (value) {
              setState(() {
                selectedCard = value;
              });
            },
            onDelete: () {
              setState(() {
                savedCards.removeWhere((c) =>
                    c['stripePaymentMethodId'] ==
                    card['stripePaymentMethodId']);
              });
            },
          ),
        NewCardOption(
          selectedCard: selectedCard,
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
                          await createCustomerAndSetupIntent();
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
          onSave: createCustomerAndSetupIntent,
        ),
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

  Widget newCardForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CardFormField(),
      ],
    );
  }
}
