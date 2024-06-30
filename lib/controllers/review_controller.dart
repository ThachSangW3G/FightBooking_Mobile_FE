import 'dart:convert';

import 'package:flightbooking_mobile_fe/models/review.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewController extends GetxController {
  final String _baseURL = 'http://flightbookingbe-production.up.railway.app';
  final listReview = <Review>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAirports();
  }

  void fetchAirports() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseURL/reviews/getAllReview'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        listReview.value = data.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }
}
