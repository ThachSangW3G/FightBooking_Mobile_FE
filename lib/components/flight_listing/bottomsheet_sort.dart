import 'package:flightbooking_mobile_fe/controllers/airline_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/seat_class_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/sort_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_styles.dart';
import '../../controllers/airport_controller.dart';
import '../../controllers/flight_controller.dart';

class BottomSheetSort extends StatefulWidget {
  const BottomSheetSort({super.key});

  @override
  State<BottomSheetSort> createState() => _BottomSheetSortState();
}

class _BottomSheetSortState extends State<BottomSheetSort> {
  final SortController sortController = Get.put(SortController());

  final AirlineController airlineController = Get.put(AirlineController());
  final FlightController flightController = Get.put(FlightController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final AirportController airportController = Get.put(AirportController());
  final SeatClassController seatClassController =
      Get.put(SeatClassController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Sắp xếp',
              style: kLableSize20w700Black,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.maxFinite,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEBEBF0),
                  ),
                ),
              ),
            ),
            ListView.builder(
                itemCount: sortController.sorts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      sortController.selectedSort(index);

                      if (flightController.departureFlight.value == null) {
                        flightController.filterFlights(
                            dateTimeController.selectDate.value!,
                            airportController.selectedDeparture.value!.id,
                            airportController.selectedDestination.value!.id,
                            seatClassController.selectedSeatClass.value,
                            sortController.selectedSort.value,
                            airlineController.selectFilterAirline.value);
                      } else {
                        flightController.filterFlights(
                            dateTimeController.selectDate.value!,
                            airportController.selectedDestination.value!.id,
                            airportController.selectedDeparture.value!.id,
                            seatClassController.selectedSeatClass.value,
                            sortController.selectedSort.value,
                            airlineController.selectFilterAirline.value);
                      }

                      Get.back();
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                sortController.sorts[index].title,
                                style: kLableSize18w700Black,
                              ),
                            ),
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  height: 30,
                                  width: 30,
                                  child:
                                      sortController.selectedSort.value == index
                                          ? SvgPicture.asset(
                                              'assets/icons/checkselect.svg')
                                          : const SizedBox(),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color.fromARGB(255, 226, 226, 230),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
