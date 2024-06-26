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

  Future<List<DateTime>> getDateList(DateTime start, DateTime end) async {
    List<DateTime> dates = [];
    DateTime current = start;

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(Duration(days: 1));
    }

    return dates;
  }

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

  String getWeekday(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Thứ Hai';
      case DateTime.tuesday:
        return 'Thứ Ba';
      case DateTime.wednesday:
        return 'Thứ Tư';
      case DateTime.thursday:
        return 'Thứ Năm';
      case DateTime.friday:
        return 'Thứ Sáu';
      case DateTime.saturday:
        return 'Thứ Bảy';
      case DateTime.sunday:
        return 'Chủ Nhật';
      default:
        return '';
    }
  }
}
