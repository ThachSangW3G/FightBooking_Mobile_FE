import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BottomSheetSelectFlight extends StatefulWidget {
  const BottomSheetSelectFlight({super.key});

  @override
  State<BottomSheetSelectFlight> createState() =>
      _BottomSheetSelectFlightState();
}

class _BottomSheetSelectFlightState extends State<BottomSheetSelectFlight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 600,
        width: double.maxFinite,
        child: Column(
          children: [
            Text(
              'Chuyến đi được chọn',
              style: kLableTextBlackW600,
            )
          ],
        ),
      ),
    );
  }
}
