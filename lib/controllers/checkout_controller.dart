import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var flightList = <Map<String, dynamic>>[].obs;
  var priceList = <Map<String, dynamic>>[].obs;
  var passengerList = <Map<String, dynamic>>[].obs;

  void setFlightList(List<Map<String, dynamic>> flights) {
    flightList.assignAll(flights);
  }

  void setPriceList(List<Map<String, dynamic>> prices) {
    priceList.assignAll(prices);
  }

  void setPassengerList(List<Map<String, dynamic>> passengers) {
    passengerList.assignAll(passengers);
  }
}
