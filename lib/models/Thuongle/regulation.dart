class Regulation {
  final int id;
  final double firstClassPrice;
  final double businessPrice;
  final double economyPrice;

  Regulation({
    required this.id,
    required this.firstClassPrice,
    required this.businessPrice,
    required this.economyPrice,
  });

  factory Regulation.fromJson(Map<String, dynamic> json) {
    return Regulation(
      id: json['id'] ?? 0,
      firstClassPrice: (json['firstClassPrice'] ?? 0).toDouble(),
      businessPrice: (json['businessPrice'] ?? 0).toDouble(),
      economyPrice: (json['economyPrice'] ?? 0).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Regulation(id: $id, firstClassPrice: $firstClassPrice, businessPrice: $businessPrice, economyPrice: $economyPrice)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstClassPrice': firstClassPrice,
      'businessPrice': businessPrice,
      'economyPrice': economyPrice,
    };
  }
}
