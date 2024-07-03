import 'package:flightbooking_mobile_fe/components/flight_listing/flight_item.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/flight_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/passenger_controller.dart';
import 'package:flightbooking_mobile_fe/screens/trip_summary/trip_summary_screen.dart';
import 'package:flutter/material.dart';
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
  final PassengerController passengerController =
      Get.put(PassengerController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.maxFinite,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Chuyến đi được chọn',
                    style: kLableTextBlackW600,
                  ),
                  Obx(
                    () => flightController.departureFlight.value != null
                        ? FlightItem(
                            flight: flightController.departureFlight.value!,
                            isSelected: true,
                            onClose: () {
                              flightController.setDepartureFlight(null);
                            },
                          )
                        : Column(
                            children: [
                              Container(
                                height: 150,
                                width: 200,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/empty.png'))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Bạn chưa chọn chuyến đi',
                                style: kLableTextBlackW600Size16,
                              ),
                            ],
                          ),
                  ),
                  dateTimeController.isRoundTrip.value
                      ? Text(
                          'Chuyến về được chọn',
                          style: kLableTextBlackW600,
                        )
                      : Container(),
                  dateTimeController.isRoundTrip.value
                      ? Obx(
                          () => flightController.returnFlight.value != null
                              ? FlightItem(
                                  flight: flightController.returnFlight.value!,
                                  isSelected: true,
                                  onClose: () {
                                    flightController.setReturnFlight(null);
                                  },
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/empty.png'))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Bạn chưa chọn chuyến về',
                                      style: kLableTextBlackW600Size16,
                                    ),
                                  ],
                                ),
                        )
                      : const SizedBox(),
                ],
              ),
              ButtonBlue(
                  des: 'Đặt vé',
                  onPress: () {
                    if (dateTimeController.isRoundTrip.value &&
                        flightController.departureFlight.value != null &&
                        flightController.returnFlight.value != null) {
                      Get.to(() => TripSummaryScreen(
                            departureFlightId:
                                flightController.departureFlight.value!.id,
                            returnFlightId:
                                flightController.returnFlight.value!.id,
                            numAdults: passengerController.adult.value,
                            numChildren: passengerController.children.value,
                            numInfants: passengerController.babe.value,
                          ));
                    } else if (!dateTimeController.isRoundTrip.value &&
                        flightController.departureFlight.value != null) {
                      Get.to(() => TripSummaryScreen(
                            departureFlightId:
                                flightController.departureFlight.value!.id,
                            numAdults: passengerController.adult.value,
                            numChildren: passengerController.children.value,
                            numInfants: passengerController.babe.value,
                          ));
                    } else {
                      final snackDemo = SnackBar(
                        content: Text(
                          'Vui lòng chọn chuyến bay!',
                          style: kLableW800White,
                        ),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackDemo);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
