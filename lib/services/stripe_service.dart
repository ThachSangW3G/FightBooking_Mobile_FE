import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StripeService {
  final String baseUrl;

  StripeService({required this.baseUrl});

  Future<String> getUsernameFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenAccess');

    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/token?token=$token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      return userData['username'];
    } else {
      throw Exception('Failed to fetch username from token');
    }
  }

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

  Future<void> chargeSavedCard(String email, String paymentMethodId,
      double amount, List<Map<String, dynamic>> bookingRequests) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/payment/charge-saved-card?email=$email&paymentMethodId=$paymentMethodId&amount=$amount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({"bookingRequests": bookingRequests}),
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId;

      // Fetch customer ID from the database
      final userResponse = await http.get(
        Uri.parse(
            '$baseUrl/payment/get-stripe-customer-id?token=${prefs.getString('tokenAccess')}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (userResponse.statusCode == 200) {
        final userData = jsonDecode(userResponse.body);
        customerId = userData['stripeCustomerId'];
      } else {
        throw Exception('Failed to fetch user data: ${userResponse.body}');
      }

      // If customerId is null, create a new customer
      if (customerId == null) {
        final createCustomerResponse = await http.post(
          Uri.parse('$baseUrl/payment/create-customer?email=$email'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
        );

        if (createCustomerResponse.statusCode == 200) {
          final customerData = jsonDecode(createCustomerResponse.body);
          customerId = customerData['customerId'];
        } else {
          throw Exception(
              'Failed to create customer: ${createCustomerResponse.body}');
        }
      }

      // Create a setup intent for the new card
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

  Future<void> deleteSavedCard(String email, String paymentMethodId) async {
    final response = await http.delete(
      Uri.parse(
          '$baseUrl/api/delete-card?email=$email&paymentMethodId=$paymentMethodId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete card');
    }
  }
}
