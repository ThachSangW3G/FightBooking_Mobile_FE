class Seat {
  final String seatClass;
  final String status;

  Seat({required this.seatClass, required this.status});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatClass: json['class'],
      status: json['status'],
    );
  }
}
