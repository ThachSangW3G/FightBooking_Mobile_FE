import 'package:get/get.dart';

class DateTimeController extends GetxController {
  var isRoundTrip = false.obs;

  var rangeStart = DateTime.now().obs;
  var rangeEnd = Rx<DateTime?>(null);

  var listDate = [
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
    DateTime(2024, 04, 22),
  ];

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    rangeStart.value = selectedDay;
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    if (start != null) {
      rangeStart.value = start;
    }
    if (end != null) {
      rangeEnd.value = end;
    }
  }

  void changeRoundTrip(bool value) {
    isRoundTrip.value = value;
    if (isRoundTrip.isFalse) {
      rangeEnd.value = null;
    }
  }
}
