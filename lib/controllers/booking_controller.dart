import 'package:get/get.dart';

class BookingController extends GetxController {
  var departureFlightId = 0.obs;
  var returnFlightId = 0.obs;
  var totalPrice = 0.0.obs;
  var contactDetails = {}.obs;
  var departurePassengerDetails = <Map<String, String>>[].obs;
  var returnPassengerDetails = <Map<String, String>>[].obs;
  var passengerDetails = <Map<String, String>>[].obs;
  var selectedDepartureSeats = <String>[].obs;
  var selectedReturnSeats = <String>[].obs;

  void setBookingDetails({
    required int departureId,
    int? returnId,
    required double price,
    required Map<String, String> contact,
    required List<Map<String, String>> departurePassengerDetails,
    required List<Map<String, String>> returnPassengerDetails,
    required List<String> departureSeats,
    required List<Map<String, String>> passengers,
    List<String>? returnSeats,
  }) {
    departureFlightId.value = departureId;
    if (returnId != null) returnFlightId.value = returnId;
    totalPrice.value = price;
    contactDetails.value = contact;
    departurePassengerDetails.assignAll(departurePassengerDetails);
    returnPassengerDetails.assignAll(returnPassengerDetails);
    passengerDetails.assignAll(passengers);
    selectedDepartureSeats.assignAll(departureSeats);
    if (returnSeats != null) selectedReturnSeats.assignAll(returnSeats);
  }
}
