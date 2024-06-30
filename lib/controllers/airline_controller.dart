import 'dart:convert';

import 'package:flightbooking_mobile_fe/models/airlines/airline.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AirlineController extends GetxController {
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  var selectFilterAirline = Rx<List<int>>([]);

  void addFilterAirline(int id) {
    final list = selectFilterAirline.value;
    list.add(id);
    print(111);
    selectFilterAirline.value = list;
    selectFilterAirline.refresh();
  }

  void removeFilterAirline(int id) {
    final list = selectFilterAirline.value;
    list.remove(id);
    selectFilterAirline.value = list;

    selectFilterAirline.refresh();
  }

  Future<Airline> getAirline({required int planeId}) async {
    final uri =
        Uri.parse('$_baseURL/airlines/get-airline-by-planeId?planeId=$planeId');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final id = jsonData['id'];
        final airlineName = jsonData['airlineName'];
        final logoUrl = jsonData['logoUrl'];
        final picture = (jsonData['picture'] as List).cast<String>();

        print(picture);

        final airline = Airline(
            id: id,
            airlineName: airlineName,
            logoUrl: logoUrl,
            picture: picture);
        print(airline);
        return airline;
      } else {
        throw Exception('Failed to load airline');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load airline');
    }
  }

  Future<List<Airline>> getAllAirline() async {
    final uri = Uri.parse('$_baseURL/airlines');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        print(jsonData);
        List<Airline> responseAirline = [];
        jsonData.forEach((element) {
          final id = element['id'];
          final airlineName = element['airlineName'];
          final logoUrl = element['logoUrl'];
          final picture = (element['picture'] as List).cast<String>();

          print(picture);

          final airline = Airline(
              id: id,
              airlineName: airlineName,
              logoUrl: logoUrl,
              picture: picture);

          responseAirline.add(airline);
        });
        print(responseAirline);

        return responseAirline;
      } else {
        throw Exception('Failed to load airline');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load airline');
    }
  }
}
