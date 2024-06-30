class Review {
  final int id;
  final String famousPlace;
  final String title;
  final String description;
  final String subDescription;
  final String conclude;
  final List<String> listImage;
  final int price;

  Review(
      {required this.id,
      required this.famousPlace,
      required this.title,
      required this.description,
      required this.subDescription,
      required this.conclude,
      required this.listImage,
      required this.price});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      famousPlace: json['famousPlace'],
      title: json['title'],
      description: json['description'],
      subDescription: json['subDescription'],
      conclude: json['conclude'],
      listImage: List<String>.from(
          json['listImage']), // Ensure this converts the list properly
      price: json['price'],
    );
  }
}
