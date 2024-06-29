import 'package:flightbooking_mobile_fe/components/flight_listing/flight_item.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/flight_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomSheetSelectFlight extends StatefulWidget {
  const BottomSheetSelectFlight({super.key});

  @override
  State<BottomSheetSelectFlight> createState() =>
      _BottomSheetSelectFlightState();
}

class _BottomSheetSelectFlightState extends State<BottomSheetSelectFlight> {
  final FlightController flightController = Get.put(FlightController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: dateTimeController.isRoundTrip.value ? 400 : 200,
        width: double.maxFinite,
        child: Column(
          children: [
            Text(
              'Chuyến đi được chọn',
              style: kLableTextBlackW600,
            ),
            flightController.departureFlight.value != null
                ? FlightItem(flight: flightController.departureFlight.value!)
                : Container(),
            dateTimeController.isRoundTrip.value
                ? Text(
                    'Chuyến về được chọn',
                    style: kLableTextBlackW600,
                  )
                : Container(),
            flightController.returnFlight.value != null
                ? FlightItem(flight: flightController.returnFlight.value!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
