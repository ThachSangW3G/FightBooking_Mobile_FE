import 'package:flightbooking_mobile_fe/screens/checkout/widgets/ticket/flight_ticket.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/ticket_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TicketItem extends StatelessWidget {
  final Ticket ticket;

  TicketItem({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: AppColors.aero_blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Xuất vé thành công',
                style: TextStyle(
                  color: AppColors.philippine_green,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Image.network(
                  ticket.airlineLogo,
                  height: 60,
                  alignment: Alignment.center,
                ),
                SizedBox(width: 8),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.location_on),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.iataCodeDepart,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // Icon for arrive)
                    Text(ticket.formattedDepartDate),
                    Text(ticket.formattedDepartDateWithDay),
                  ],
                ),
                Column(
                  children: [
                    Text('2g 00p'),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ticket.iataCodeArrival,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      ticket.formattedArrivalDate,
                    ),
                    Text(ticket.formattedArrivalDateWithDay),
                  ],
                ),
                Icon(Icons.location_on),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ghế ngồi: ' + ticket.seatNumber.join(', ')),
                ],
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mã vé: ${ticket.bookingId.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.to(() => TicketDetailsScreen(bookingId: ticket.bookingId));
              },
              child: Text(
                'Xem chi tiết vé',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
