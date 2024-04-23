import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/view_ticket_screen.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              },
              child: Text('Checkout'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nhấn nút View Checkout
              },
              child: Text('View Checkout'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketScreenWidget()),
                );
              },
              child: Text('View Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}
