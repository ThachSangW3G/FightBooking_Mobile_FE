class PaymentMethodDTO {
  final String stripePaymentMethodId;
  final String cardLast4;
  final String cardBrand;

  PaymentMethodDTO({
    required this.stripePaymentMethodId,
    required this.cardLast4,
    required this.cardBrand,
  });

  factory PaymentMethodDTO.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDTO(
      stripePaymentMethodId: json['stripePaymentMethodId'],
      cardLast4: json['cardLast4'],
      cardBrand: json['cardBrand'],
    );
  }
}
