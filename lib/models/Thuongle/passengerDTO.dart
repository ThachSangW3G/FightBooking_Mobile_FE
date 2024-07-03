class PassengerDTO {
  String fullName;
  String email;
  String personalId;
  String seatNumber;

  PassengerDTO({
    required this.fullName,
    required this.email,
    required this.personalId,
    required this.seatNumber,
  });

  factory PassengerDTO.fromJson(Map<String, dynamic> json) {
    return PassengerDTO(
      fullName: json['fullName'],
      email: json['email'],
      personalId: json['personalId'],
      seatNumber: json['seatNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'personalId': personalId,
      'seatNumber': seatNumber,
    };
  }
}
