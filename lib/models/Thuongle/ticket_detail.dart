import 'package:intl/intl.dart';
import 'package:flightbooking_mobile_fe/models/Thuongle/passengerDTO.dart';

class TicketDetailResponse {
  int flightId;
  String bookerFullName;
  String bookerPhoneNumber;
  String bookerEmail;
  String airlineLogoUrl;
  String airlineName;
  String planeNumber;
  String departureAirportName;
  String arrivalAirportName;
  String iataArrivalCode;
  String iataDepartureCode;
  int departureDate; // milliseconds since epoch
  int arrivalDate; // milliseconds since epoch
  List<PassengerDTO> passengerDTOList;

  TicketDetailResponse({
    required this.flightId,
    required this.bookerFullName,
    required this.bookerPhoneNumber,
    required this.bookerEmail,
    required this.airlineLogoUrl,
    required this.airlineName,
    required this.planeNumber,
    required this.departureAirportName,
    required this.arrivalAirportName,
    required this.iataArrivalCode,
    required this.iataDepartureCode,
    required this.departureDate,
    required this.arrivalDate,
    required this.passengerDTOList,
  });

  factory TicketDetailResponse.fromJson(Map<String, dynamic> json) {
    var list = json['passengerDTOList'] as List;
    List<PassengerDTO> passengersList =
        list.map((i) => PassengerDTO.fromJson(i)).toList();

    return TicketDetailResponse(
      flightId: json['flightId'],
      bookerFullName: json['bookerFullName'],
      bookerPhoneNumber: json['bookerPhoneNumber'],
      bookerEmail: json['bookerEmail'],
      airlineLogoUrl: json['airlineLogoUrl'],
      airlineName: json['airlineName'],
      planeNumber: json['planeNumber'],
      departureAirportName: json['departureAirportName'],
      arrivalAirportName: json['arrivalAirportName'],
      iataArrivalCode: json['iataArrivalCode'],
      iataDepartureCode: json['iataDepartureCode'],
      departureDate: json['departureDate'] ?? 0,
      arrivalDate: json['arrivalDate'] ?? 0,
      passengerDTOList: passengersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flightId': flightId,
      'bookerFullName': bookerFullName,
      'bookerPhoneNumber': bookerPhoneNumber,
      'bookerEmail': bookerEmail,
      'airlineLogoUrl': airlineLogoUrl,
      'airlineName': airlineName,
      'planeNumber': planeNumber,
      'departureAirportName': departureAirportName,
      'arrivalAirportName': arrivalAirportName,
      'iataArrivalCode': iataArrivalCode,
      'iataDepartureCode': iataDepartureCode,
      'departureDate': departureDate,
      'arrivalDate': arrivalDate,
      'passengerDTOList': passengerDTOList.map((i) => i.toJson()).toList(),
    };
  }
}
