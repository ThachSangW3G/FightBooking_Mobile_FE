import 'dart:convert';
import 'package:flightbooking_mobile_fe/components/payments/new_card_option.dart';
import 'package:flightbooking_mobile_fe/components/payments/payment_option.dart';
import 'package:flightbooking_mobile_fe/components/payments/saved_card_item.dart';
import 'package:flightbooking_mobile_fe/controllers/flight_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flightbooking_mobile_fe/services/stripe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> flightDetails;
  final double totalAmount;

  const PaymentScreen({
    required this.flightDetails,
    required this.totalAmount,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  String? selectedCard;
  bool isChecked = false;
  bool _isProcessing = false;
  final FlightController flightController = Get.put(FlightController());
  final UserController userController = Get.find<UserController>();
  final StripeService stripeService = StripeService(
      baseUrl: 'https://flightbookingbe-production.up.railway.app');

  List<Map<String, dynamic>> savedCards = [];

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        'pk_test_51OVwerA7WrEjctnX9STvulzywtvSiHbBfwpWtPz1qUisHRlxGoqeYEsezmX3wub802xxdEyo6N65w2zLu77HLP3200k4IHYlWU';
    fetchSavedCards();
  }

  Future<void> fetchSavedCards() async {
    final cards = await stripeService
        .fetchSavedCards(userController.currentUser.value!.email!);
    setState(() {
      savedCards = cards;
    });
  }

  Future<void> chargeSavedCard(String email, String paymentMethodId,
      double amount, List<Map<String, dynamic>> bookingRequests) async {
    try {
      await stripeService.chargeSavedCard(
          email, paymentMethodId, amount, bookingRequests);
      updateSeatStatus();
    } catch (e) {
      print('Error during chargeSavedCard: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to charge saved card. Please try again.')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> deleteCard(String paymentMethodId) async {
    try {
      await stripeService.deleteSavedCard(
        userController.currentUser.value!.email!,
        paymentMethodId,
      );
      setState(() {
        savedCards.removeWhere(
            (card) => card['stripePaymentMethodId'] == paymentMethodId);
      });
    } catch (e) {
      print('Error during deleteCard: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete card. Please try again.')),
      );
    }
  }

  Future<void> createCustomerAndSetupIntent() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('tokenAccess');
      if (token == null) {
        // Handle missing token
        return;
      }
      String username = await stripeService.getUsernameFromToken();

      final newCard = await stripeService.createCustomerAndSetupIntent(
          userController.currentUser.value!.email!, username);
      setState(() {
        savedCards.add(newCard);
        selectedCard = newCard['stripePaymentMethodId'];
      });
      Navigator.of(context).pop();
    } catch (e) {
      print('Error during createCustomerAndSetupIntent: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set up the card. Please try again.')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> updateSeatStatus() async {
    for (var flightDetail in widget.flightDetails) {
      final seatNumbers = [
        ...widget.flightDetails[0]['passengers'],
        if (widget.flightDetails.length > 1)
          ...widget.flightDetails[1]['passengers'],
      ]
          .where((p) => p['flightId'] == flightDetail['flightId'])
          .map((p) => p['seatNumber'])
          .toSet()
          .toList();
      final response = await http.post(
        Uri.parse(
            'https://flightbookingbe-production.up.railway.app/booking/book-seat-before-booking?flightId=${flightDetail['flightId']}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(seatNumbers),
      );

      if (response.statusCode != 200) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update seat status. Please try again.')),
        );
        return;
      }
      print(seatNumbers);
    }
  }

  Future<void> handlePayment() async {
    if (widget.flightDetails.length == 2) {
      // Chia tổng số tiền thành hai phần bằng nhau
      final amountPerFlight = widget.totalAmount / 2;

      // Thực hiện thanh toán cho chuyến đi
      await chargeSavedCard(
        userController.currentUser.value!.email!,
        selectedCard!,
        amountPerFlight,
        [
          widget.flightDetails[0],
        ],
      );

      // Thực hiện thanh toán cho chuyến về
      await chargeSavedCard(
        userController.currentUser.value!.email!,
        selectedCard!,
        amountPerFlight,
        [
          widget.flightDetails[1],
        ],
      );
    } else {
      // Thực hiện thanh toán cho chuyến bay một chiều
      await chargeSavedCard(
        userController.currentUser.value!.email!,
        selectedCard!,
        widget.totalAmount,
        widget.flightDetails,
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
          onPressed: () {
            Get.back();
          },
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
              ],
            ),
          ),
          if (_isProcessing) Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng cộng',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text('${widget.totalAmount.toStringAsFixed(0)} \$',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (selectedPaymentMethod != null &&
                    selectedPaymentMethod!.isNotEmpty) {
                  setState(() {
                    _isProcessing = true;
                  });
                  if (selectedPaymentMethod == 'Visa' &&
                      (selectedCard != null || selectedCard == 'new_card')) {
                    if (selectedCard == 'new_card') {
                      await createCustomerAndSetupIntent();
                    } else {
                      await handlePayment();
                      flightController.departureFlight.value = null;
                      flightController.returnFlight.value = null;
                      Get.off(() => const PaymentSuccessfulWidget());
                    }
                  } else {
                    // Handle other payment methods
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
              child: Text(
                'Thanh toán',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
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
            onDelete: () async {
              await deleteCard(card['stripePaymentMethodId']);
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
