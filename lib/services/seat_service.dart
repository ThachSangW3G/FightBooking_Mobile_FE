import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flightbooking_mobile_fe/models/Thuongle/seat.dart';

Future<Map<String, Seat>> fetchSeats(int flightId) async {
  final response = await http.get(Uri.parse(
      'https://flightbookingbe-production.up.railway.app/flight/$flightId/get-seat-status?flightId=$flightId'));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return json.map((key, value) => MapEntry(key, Seat.fromJson(value)));
  } else {
    throw Exception('Failed to load seat data');
  }
}
