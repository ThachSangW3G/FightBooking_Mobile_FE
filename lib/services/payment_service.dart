import 'package:flightbooking_mobile_fe/models/PaymentMethodDTO.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  final String baseUrl;

  PaymentService({required this.baseUrl});

  Future<String?> getCustomerId(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-stripe-customer-id?token=$token'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    print('getCustomerId response: ${response.body}'); // Log the response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['stripeCustomerId'];
    } else {
      return null;
    }
  }

  Future<String> createCustomer(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-customer?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );

    print('createCustomer response: ${response.body}'); // Log the response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['customerId'];
    } else {
      throw Exception('Failed to create customer');
    }
  }

  Future<String> createSetupIntent(String customerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-setup-intent?customerId=$customerId'),
      headers: {'Content-Type': 'application/json'},
    );

    print('createSetupIntent response: ${response.body}'); // Log the response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['clientSecret'];
    } else {
      throw Exception('Failed to create setup intent');
    }
  }

  Future<void> attachPaymentMethod(
      String customerId, String paymentMethodId) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/attach-payment-method?customerId=$customerId&paymentMethodId=$paymentMethodId'),
      headers: {'Content-Type': 'application/json'},
    );

    print('attachPaymentMethod response: ${response.body}'); // Log the response

    if (response.statusCode != 200) {
      throw Exception('Failed to attach payment method');
    }
  }

  Future<List<PaymentMethodDTO>> getPaymentMethods(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/payment-methods?email=$email'),
    );

    print('getPaymentMethods response: ${response.body}'); // Log the response

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => PaymentMethodDTO.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to fetch payment methods');
    }
  }

  Future<String> createPayment(String token, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mobile/get-total-price?token=$token&amount=$amount'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('createPayment response: ${response.body}'); // Log the response

    if (response.statusCode == 200) {
      return json.decode(response.body)['clientSecret'];
    } else {
      throw Exception('Failed to create payment');
    }
  }
}
