class Seat {
  final String seatClass;
  final String userId;
  final String status;

  Seat({required this.seatClass, required this.userId, required this.status});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatClass: json['class'],
      userId: json['userId'],
      status: json['status'],
    );
  }
}
