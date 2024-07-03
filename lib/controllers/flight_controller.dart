import 'dart:convert';

import 'package:flightbooking_mobile_fe/models/flights/flight.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FlightController extends GetxController {
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  var departureFlight = Rx<Flight?>(null);
  var returnFlight = Rx<Flight?>(null);

  var filterPriceMin = Rx<int>(0);
  var filterPriceMax = Rx<int>(0);

  var flights = Rx<List<Flight>>([]);

  var isLoading = false.obs;

  void sortByPrice(int classType) {
    switch (classType) {
      case 0:
        return flights.value
            .sort((a, b) => a.economyPrice.compareTo(b.economyPrice));
      case 1:
        return flights.value
            .sort((a, b) => a.businessPrice.compareTo(b.businessPrice));
      case 2:
        return flights.value
            .sort((a, b) => a.firstClassPrice.compareTo(b.firstClassPrice));
      default:
        return;
    }
  }

  void sortAscDepartureTime() {
    return flights.value
        .sort((a, b) => a.departureDate.compareTo(b.departureDate));
  }

  void sortDescDepartureTime() {
    return flights.value
        .sort((a, b) => b.departureDate.compareTo(a.departureDate));
  }

  void sortAscArrivalTime() {
    return flights.value.sort((a, b) => a.arrivalDate.compareTo(b.arrivalDate));
  }

  void sortDescArrivalTime() {
    return flights.value.sort((a, b) => b.arrivalDate.compareTo(a.arrivalDate));
  }

  void setFilterPriceMin(int price) {
    filterPriceMin.value = price;
  }

  void setFilterPriceMax(int price) {
    filterPriceMax.value = price;
  }

  // List<Flight> filterFlightByAirline(List<Flight> flights) {

  // }

  List<Flight> filterFlightByPrice(List<Flight> flights, int classType) {
    if (filterPriceMin.value == 0 && filterPriceMax.value == 0) {
      return flights;
    }

    if (filterPriceMax.value == 0) {
      switch (classType) {
        case 0:
          return flights
              .where((flight) => flight.economyPrice >= filterPriceMin.value)
              .toList();
        case 1:
          return flights
              .where((flight) => flight.businessPrice >= filterPriceMin.value)
              .toList();
        case 2:
          return flights
              .where((flight) => flight.firstClassPrice >= filterPriceMin.value)
              .toList();
        default:
          return flights;
      }
    }

    if (filterPriceMin.value == 0) {
      switch (classType) {
        case 0:
          return flights
              .where((flight) => flight.economyPrice <= filterPriceMax.value)
              .toList();
        case 1:
          return flights
              .where((flight) => flight.businessPrice <= filterPriceMax.value)
              .toList();
        case 2:
          return flights
              .where((flight) => flight.firstClassPrice <= filterPriceMax.value)
              .toList();
        default:
          return flights;
      }
    }

    if (classType == 0) {
      return flights
          .where((flight) =>
              flight.economyPrice >= filterPriceMin.value &&
              flight.economyPrice <= filterPriceMax.value)
          .toList();
    } else if (classType == 1) {
      return flights
          .where((flight) =>
              flight.businessPrice >= filterPriceMin.value &&
              flight.businessPrice <= filterPriceMax.value)
          .toList();
    } else {
      return flights
          .where((flight) =>
              flight.firstClassPrice >= filterPriceMin.value &&
              flight.firstClassPrice <= filterPriceMax.value)
          .toList();
    }
  }

  List<Flight> filterFlightByAirline(
      List<Flight> flights, List<int> selectedAirline) {
    if (selectedAirline.isEmpty) {
      return flights;
    }

    return flights
        .where((flight) => selectedAirline.contains(flight.airlineId))
        .toList();
  }

  Future<void> filterFlights(
      DateTime departureDate,
      int departureAirportId,
      int arrivalAirportId,
      int classType,
      int selectSort,
      List<int> selectedAirline) async {
    isLoading.value = true;
    final formatDepartureDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(departureDate);

    final uri = Uri.parse(
        '$_baseURL/flight/filter-flights?flightType=ONE_WAY&departureDate=$formatDepartureDate&departureAirportId=$departureAirportId&arrivalAirportId=$arrivalAirportId&classType=economy&order=asc');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

        print(jsonData);

        final List<Flight> flightsResponse = [];
        jsonData.forEach((element) {
          final id = element['id'];

          final departureDate =
              DateTime.fromMillisecondsSinceEpoch(element['departureDate']);

          final arrivalDate =
              DateTime.fromMillisecondsSinceEpoch(element['arrivalDate']);
          print(departureDate);
          print(arrivalDate);

          final departureAirportId = element['departureAirportId'];
          final arrivalAirportId = element['arrivalAirportId'];
          final planeId = element['planeId'];
          final economyPrice = element['economyPrice'];
          final businessPrice = element['businessPrice'];
          final firstClassPrice = element['firstClassPrice'];
          final flightStatus = element['flightStatus'];
          final duration = element['duration'];
          final airlineId = element['airlineId'];
          final airlineName = element['airlineName'];

          final flight = Flight(
              id: id,
              flightStatus: flightStatus,
              departureDate: departureDate,
              arrivalDate: arrivalDate,
              departureAirportId: departureAirportId,
              arrivalAirportId: arrivalAirportId,
              planeId: planeId,
              economyPrice: economyPrice,
              businessPrice: businessPrice,
              firstClassPrice: firstClassPrice,
              duration: duration,
              airlineId: airlineId,
              airlineName: airlineName);
          print(flight);

          flightsResponse.add(flight);
        });

        flights.value = filterFlightByAirline(
            filterFlightByPrice(flightsResponse, classType), selectedAirline);

        switch (selectSort) {
          case 0:
            sortByPrice(classType);
            break;
          case 1:
            sortAscDepartureTime();
            break;
          case 2:
            sortDescDepartureTime();
            break;
          case 3:
            sortAscArrivalTime();
            break;
          case 4:
            sortDescArrivalTime();
            break;
          default:
            break;
        }
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load flights');
    } finally {
      isLoading.value = false;
    }
  }

  void setDepartureFlight(Flight? flight) {
    departureFlight.value = flight;
  }

  void setReturnFlight(Flight? flight) {
    returnFlight.value = flight;
  }

  int getNumberFlightSelected() {
    if (departureFlight.value != null && returnFlight.value != null) {
      return 2;
    } else if (departureFlight.value != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
