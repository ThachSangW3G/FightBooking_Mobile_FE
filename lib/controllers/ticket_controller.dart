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
    fetchTickets();
  }

  void fetchTickets() async {
    try {
      isLoading(true);
      var fetchedTickets = await ticketService.getTicketsByUserId();
      tickets.value = fetchedTickets;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
