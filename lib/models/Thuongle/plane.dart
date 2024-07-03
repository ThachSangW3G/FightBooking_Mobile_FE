class Plane {
  final int id;
  final String planeNumber;

  Plane({
    required this.id,
    required this.planeNumber,
  });

  factory Plane.fromJson(Map<String, dynamic> json) {
    return Plane(
      id: json['id'] ?? 0,
      planeNumber: json['flightNumber'] ?? 'Unknown Plane',
    );
  }

  @override
  String toString() {
    return 'Plane(id: $id, flightNumber: $planeNumber)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planeNumber': planeNumber,
    };
  }
}
