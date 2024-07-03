import 'package:flightbooking_mobile_fe/components/ticket/ticket_item.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/ticket_controller.dart';
import 'package:flightbooking_mobile_fe/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketScreenWidget extends StatefulWidget {
  @override
  _TicketScreenWidgetState createState() => _TicketScreenWidgetState();
}

class _TicketScreenWidgetState extends State<TicketScreenWidget> {
  final TicketController ticketController = Get.put(TicketController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        title: Text('Vé của tôi', style: kLableSize20w700White),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ticketController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (ticketController.tickets.isEmpty) {
          return Center(child: Text('No tickets found'));
        } else {
          return ListView.builder(
            itemCount: ticketController.tickets.length,
            itemBuilder: (context, index) {
              final ticket = ticketController.tickets[index];
              return TicketItem(ticket: ticket);
            },
          );
        }
      }),
    );
  }
}
