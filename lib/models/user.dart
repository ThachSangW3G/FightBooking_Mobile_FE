class User {
  int id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? gender;
  DateTime? dayOfBirth;
  String? personalId;
  String? avatarUrl;

  User(
      {required this.id,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.address,
      this.gender,
      this.dayOfBirth,
      this.personalId,
      this.avatarUrl});
}
