import 'package:flutter/material.dart';

class Passenger {
  final String name;
  final String email;
  final DateTime birthday;

  Passenger({
    required this.name,
    required this.email,
    required this.birthday,
  });
}

class FlightPassengerContactWidget extends StatelessWidget {
  final Passenger representative; // Thông tin người đại diện
  final List<Passenger> passengers; // Danh sách hành khách

  const FlightPassengerContactWidget({
    Key? key,
    required this.representative,
    required this.passengers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin liên hệ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        // Hiển thị thông tin người đại diện
        Text('Người đại diện: ${representative.name}'),
        Text('Email: ${representative.email}'),
        Text('Ngày sinh: ${representative.birthday}'),
        SizedBox(height: 8),
        // Hiển thị danh sách hành khách
        Text(
          'Danh sách hành khách:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: passengers
              .map(
                (passenger) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hành khách: ${passenger.name}'),
                    Text('Email: ${passenger.email}'),
                    Text('Ngày sinh: ${passenger.birthday}'),
                    SizedBox(height: 8),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
