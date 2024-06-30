import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentController {
  final String baseUrl;

  PaymentController({required this.baseUrl});

  Future<http.Response> registerCard({
    required String stripePaymentMethodId,
    required String last4Digits,
    required String expiryDate,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payment/register-card'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'stripePaymentMethodId': stripePaymentMethodId,
        'last4Digits': last4Digits,
        'expiryDate': expiryDate,
      }),
    );

    return response;
  }
}
