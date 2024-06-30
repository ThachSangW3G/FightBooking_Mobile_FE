import 'package:get/get.dart';

class DateTimeController extends GetxController {
  var isRoundTrip = false.obs;

  var rangeStart = DateTime.now().obs;
  var rangeEnd = Rx<DateTime?>(null);

  var listDate = Rx<List<DateTime>>([]);

  var selectDate = Rx<DateTime?>(null);

  Future<void> getDateList() async {
    List<DateTime> dates = [];
    DateTime current = rangeStart.value;

    while (current.isBefore(isRoundTrip.value
            ? rangeEnd.value!
            : rangeStart.value.add(const Duration(days: 10))) ||
        current.isAtSameMomentAs(isRoundTrip.value
            ? rangeEnd.value!
            : rangeStart.value.add(const Duration(days: 10)))) {
      dates.add(current);
      current = current.add(Duration(days: 1));
    }

    listDate.value = dates;
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

  int getIndexInListDate(DateTime dateTime) {
    return listDate.value.indexOf(dateTime);
  }
}
