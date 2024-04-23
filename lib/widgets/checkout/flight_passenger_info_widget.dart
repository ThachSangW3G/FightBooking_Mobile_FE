import 'package:flutter/material.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';

class FlightPassengerInfoWidget extends StatelessWidget {
  final String passengerName;
  final String passengerType;

  const FlightPassengerInfoWidget({
    required this.passengerName,
    required this.passengerType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hành khách - ${passengerType}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                    height:
                        4), // Add some space between "Hành khách - Type" and the passenger name
                Row(
                  children: [
                    Icon(
                      _getIconForPassengerType(passengerType),
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${passengerName.toUpperCase()}', // Convert passenger name to uppercase
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  IconData _getIconForPassengerType(String type) {
    switch (type) {
      case 'Người lớn':
        return Icons.person;
      case 'Trẻ em':
        return Icons.person;
      case 'Em bé':
        return Icons.person;
      default:
        return Icons.person;
    }
  }
}
