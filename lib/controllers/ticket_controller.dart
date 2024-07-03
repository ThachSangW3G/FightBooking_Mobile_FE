import 'package:get/get.dart';
import 'package:flightbooking_mobile_fe/services/ticket_service.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/ticket/flight_ticket.dart';

class TicketController extends GetxController {
  final TicketService ticketService = TicketService(
      baseUrl: 'https://flightbookingbe-production.up.railway.app');
  var tickets = <Ticket>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicketsStream();
  }

  void fetchTicketsStream() {
    Stream.periodic(Duration(seconds: 10))
        .asyncMap((_) => ticketService.getTicketsByUserId())
        .listen((fetchedTickets) {
      tickets.value = fetchedTickets;
      isLoading(false);
    }, onError: (error) {
      Get.snackbar('Error', error.toString());
      isLoading(false);
    });
  }
}
