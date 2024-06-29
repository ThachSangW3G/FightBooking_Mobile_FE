import 'package:flightbooking_mobile_fe/screens/payments/payment_successful.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  final String baseUrl;

  StripeService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchSavedCards(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/payment/saved-cards?email=$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> cardsData = jsonDecode(response.body);
      return cardsData
          .map((card) => {
                'stripePaymentMethodId': card['stripePaymentMethodId'],
                'cardLast4': card['cardLast4'],
                'cardBrand': card['cardBrand']
              })
          .toList();
    } else {
      throw Exception('Failed to fetch saved cards');
    }
  }

  Future<void> chargeSavedCard(
      String email, String paymentMethodId, double amount) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/payment/charge-saved-card?email=$email&paymentMethodId=$paymentMethodId&amount=$amount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final clientSecret = responseData['clientSecret'];
      print('Client Secret: $clientSecret');
    } else {
      print('Failed to charge saved card: ${response.body}');
      throw Exception('Failed to charge saved card: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createCustomerAndSetupIntent(
      String email, String username) async {
    try {
      final userResponse = await http.get(
        Uri.parse('$baseUrl/payment/get-stripe-customer-id?' +
            'token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0aHVvbmdzcCIsImlhdCI6MTcxOTY0NjY3MywiZXhwIjoxNzE5NjYxMDczfQ.1ZPod2ieSg4M_gcDpc9tjM3X_3zRDZOz3QsF0qL-VKs'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      String? customerId;
      if (userResponse.statusCode == 200) {
        final userData = jsonDecode(userResponse.body);
        customerId = userData['stripeCustomerId'];
        if (customerId == null) {
          final response = await http.post(
            Uri.parse('$baseUrl/payment/create-customer?email=$email'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
          );

          if (response.statusCode == 200) {
            final customerData = jsonDecode(response.body);
            customerId = customerData['customerId'];
          } else {
            throw Exception('Failed to create customer: ${response.body}');
          }
        }
      } else {
        throw Exception('Failed to fetch user data: ${userResponse.body}');
      }

      final setupIntentResponse = await http.post(
        Uri.parse(
            '$baseUrl/payment/create-setup-intent?customerId=$customerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (setupIntentResponse.statusCode == 200) {
        final setupIntentData = jsonDecode(setupIntentResponse.body);
        final clientSecret = setupIntentData['clientSecret'];
        final setupIntentId = setupIntentData['setupIntentId'];

        await Stripe.instance.confirmSetupIntent(
          paymentIntentClientSecret: clientSecret,
          params: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
              billingDetails: BillingDetails(
                email: email,
                phone: '+84987654321',
              ),
            ),
          ),
        );

        await registerCard(customerId!, setupIntentId, username);

        final newCardResponse = await http.get(
          Uri.parse('$baseUrl/payment/saved-cards?email=$email'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
        );

        if (newCardResponse.statusCode == 200) {
          final List<dynamic> cardsData = jsonDecode(newCardResponse.body);
          return cardsData
              .map((card) => {
                    'stripePaymentMethodId': card['stripePaymentMethodId'],
                    'cardLast4': card['cardLast4'],
                    'cardBrand': card['cardBrand']
                  })
              .last;
        } else {
          throw Exception('Failed to fetch saved cards');
        }
      } else {
        throw Exception(
            'Failed to create setup intent: ${setupIntentResponse.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create customer and setup intent');
    }
  }

  Future<void> registerCard(
      String customerId, String setupIntentId, String username) async {
    final url = Uri.parse('$baseUrl/payment/register-card').replace(
        queryParameters: {
          'customerId': customerId,
          'setupIntentId': setupIntentId,
          'username': username
        });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register card: ${response.body}');
    }
  }
}
