import 'dart:convert';
import 'package:flightbooking_mobile_fe/controllers/user_controller.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/ticket/flight_ticket.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TicketService {
  final String baseUrl;

  TicketService({required this.baseUrl});

  Future<List<Ticket>> getTicketsByUserId() async {
    final UserController userController = Get.find<UserController>();
    int userId = userController.currentUser.value!.id;

    if (userId == null) {
      throw Exception('Token or User ID is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/booking/get-ticket-by-user-id?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> ticketData = jsonDecode(response.body);
      return ticketData.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tickets');
    }
  }
}
