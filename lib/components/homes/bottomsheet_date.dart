import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/app_styles.dart';

class BottomSheetDate extends StatefulWidget {
  const BottomSheetDate({super.key});

  @override
  State<BottomSheetDate> createState() => _BottomSheetDateState();
}

class _BottomSheetDateState extends State<BottomSheetDate> {
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  final DateTimeController dateTimeController = Get.put(DateTimeController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Chọn ngày',
              style: kLableSize20w700Black,
            ),
            Obx(
              () => dateTimeController.isRoundTrip.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Ngày đi',
                              style: kLableSize18Black,
                            ),
                            dateTimeController.rangeEnd.value == null
                                ? Text(
                                    'dd/MM/yyyy',
                                    style: kLableSize15Grey,
                                  )
                                : Text(
                                    formatDateTime(
                                        dateTimeController.rangeStart.value),
                                    style: kLableSize15Grey,
                                  )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Ngày về',
                              style: kLableSize18Black,
                            ),
                            dateTimeController.rangeEnd.value == null
                                ? Text(
                                    'dd/MM/yyyy',
                                    style: kLableSize15Grey,
                                  )
                                : Text(
                                    formatDateTime(
                                        dateTimeController.rangeEnd.value!),
                                    style: kLableSize15Grey,
                                  )
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          'Ngày đi',
                          style: kLableSize18Black,
                        ),
                        Text(
                          formatDateTime(dateTimeController.rangeStart.value),
                          style: kLableSize15Grey,
                        )
                      ],
                    ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Obx(
              () => dateTimeController.isRoundTrip.value == true
                  ? TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: dateTimeController.rangeStart.value,
                      rangeStartDay: dateTimeController.rangeStart.value,
                      rangeEndDay: dateTimeController.rangeEnd.value,
                      onRangeSelected: dateTimeController.onRangeSelected,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      availableGestures: AvailableGestures.all,
                    )
                  : TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: dateTimeController.rangeStart.value,
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) {
                        return isSameDay(
                            dateTimeController.rangeStart.value, day);
                      },
                      onDaySelected: dateTimeController.onDaySelected),
            ),
          ],
        ));
  }
}
