import 'package:flightbooking_mobile_fe/components/homes/bottomsheet_date.dart';
import 'package:flightbooking_mobile_fe/components/homes/bottomsheet_departurepoint.dart';
import 'package:flightbooking_mobile_fe/components/homes/bottomsheet_destinationpoint.dart';
import 'package:flightbooking_mobile_fe/components/homes/bottomsheet_passenger.dart';
import 'package:flightbooking_mobile_fe/components/homes/bottomsheet_seatclass.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/airport_controller.dart';
import 'package:flightbooking_mobile_fe/screens/flight_listing/flight_listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/datetime_controller.dart';
import '../../controllers/passenger_controller.dart';
import '../../controllers/seat_class_controller.dart';

class FindFlight extends StatefulWidget {
  final String from;
  const FindFlight({super.key, required this.from});

  @override
  State<FindFlight> createState() => _FindFlightState();
}

class _FindFlightState extends State<FindFlight> {
  AirportController airportController = Get.put(AirportController());

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final PassengerController passengerController =
      Get.put(PassengerController());

  final SeatClassController seatClassController =
      Get.put(SeatClassController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.from == 'departurePoint') {
        showModalBottomSheet(
            context: context,
            builder: (_) => const BottomSheetDeparturePoint());
      } else if (widget.from == 'destinationPoint') {
        showModalBottomSheet(
            context: context,
            builder: (_) => const BottomSheetDestinationPoint());
      } else if (widget.from == 'passenger') {
        showModalBottomSheet(
            context: context, builder: (_) => const BottomSheetPassenger());
      } else if (widget.from == 'seatClass') {
        showModalBottomSheet(
            context: context, builder: (_) => const BottomSeatClass());
      } else if (widget.from == 'departureDate') {
        showModalBottomSheet(
            context: context, builder: (_) => const BottomSheetDate());
      }
    });

    if (widget.from == 'departurePoint') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
            context: context,
            builder: (_) => const BottomSheetDeparturePoint());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/banner.png',
                            ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            193, 165, 161, 161)),
                                    shape: BoxShape.circle,
                                    color: const Color(0x34707070)),
                                child:
                                    SvgPicture.asset('assets/icons/close.svg'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Golobe',
                              style: kLableTitleWhite,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          193, 165, 161, 161)),
                                  shape: BoxShape.circle,
                                  color: const Color(0x34707070)),
                              child: SvgPicture.asset(
                                'assets/icons/system.svg',
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          193, 165, 161, 161)),
                                  shape: BoxShape.circle,
                                  color: const Color(0x34707070)),
                              child: SvgPicture.asset(
                                'assets/icons/option.svg',
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          193, 165, 161, 161)),
                                  shape: BoxShape.circle,
                                  color: const Color(0x34707070)),
                              child: SvgPicture.asset(
                                'assets/icons/more.svg',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 110,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  const Offset(0, 3), // Thay đổi offset tùy ý
                            ),
                          ],
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const BottomSheetDeparturePoint());
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/planeup.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Điểm đi',
                                                style: kLableSize18Black,
                                              ),
                                              Obx(() => airportController
                                                          .selectedDeparture
                                                          .value !=
                                                      null
                                                  ? Text(
                                                      '${airportController.selectedDeparture.value!.iataCode} (${airportController.selectedDeparture.value!.city})',
                                                      style: kLableSize18Grey)
                                                  : Text('Chọn điểm đi',
                                                      style: kLableSize18Grey)),

                                              // Text(
                                              //   'Chọn điểm đi',
                                              //   style: kLableSize18Grey,
                                              // )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const BottomSheetDestinationPoint());
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/planedown.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Điểm đến',
                                                style: kLableSize18Black,
                                              ),
                                              Obx(() => airportController
                                                          .selectedDestination
                                                          .value !=
                                                      null
                                                  ? Text(
                                                      '${airportController.selectedDestination.value!.iataCode} (${airportController.selectedDestination.value!.city})',
                                                      style: kLableSize18Grey)
                                                  : Text(
                                                      'Chọn điểm đến',
                                                      style: kLableSize18Grey,
                                                    ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final success =
                                      airportController.swapAirport();
                                  if (!success) {
                                    final snackdemo = SnackBar(
                                      content: Text(
                                        'Đổi địa điểm thất bại!',
                                        style: kLableW800White,
                                      ),
                                      backgroundColor: Colors.red,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.all(5),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackdemo);
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/switch.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 312,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const BottomSheetDate());
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/calendar-from.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ngày đi',
                                                style: kLableSize18Black,
                                              ),
                                              Obx(() => Text(
                                                    formatDateTime(
                                                        dateTimeController
                                                            .rangeStart.value),
                                                    style:
                                                        kLableSize18w700Black,
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const BottomSheetDate());
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/calendar-to.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Ngày về',
                                                style: kLableSize18Black,
                                              ),
                                              Obx(() => dateTimeController
                                                          .rangeEnd.value ==
                                                      null
                                                  ? Text(
                                                      'Chọn ngày về',
                                                      style: kLableSize18Grey,
                                                    )
                                                  : Text(
                                                      formatDateTime(
                                                          dateTimeController
                                                              .rangeEnd.value!),
                                                      style:
                                                          kLableSize18w700Black,
                                                    ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Khứ hồi',
                                    style: kLableSize15Black,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Obx(
                                    () => CupertinoSwitch(
                                        activeColor: AppColors.blue,
                                        value: dateTimeController
                                            .isRoundTrip.value,
                                        onChanged: (value) {
                                          dateTimeController
                                              .changeRoundTrip(value);
                                        }),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 312,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          const BottomSheetPassenger());
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/customer.svg'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hành khách',
                                          style: kLableSize18Black,
                                        ),
                                        Obx(() => Text(
                                              '${(passengerController.adult.value + passengerController.children.value + passengerController.babe.value)} hành khách',
                                              style: kLableSize18w700Black,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const BottomSeatClass());
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset('assets/icons/seat.svg'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hạng ghế',
                                          style: kLableSize18Black,
                                        ),
                                        Obx(() => Text(
                                              seatClassController
                                                  .seatClasses[
                                                      seatClassController
                                                          .selectedSeatClass
                                                          .value]
                                                  .title,
                                              style: kLableSize18w700Black,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () async {
                              if (airportController.selectedDeparture.value ==
                                      null ||
                                  airportController.selectedDestination.value ==
                                      null ||
                                  (passengerController.adult.value +
                                          passengerController.children.value +
                                          passengerController.babe.value) ==
                                      0) {
                                final snackDemo = SnackBar(
                                  content: Text(
                                    'Vui lòng chọn đầy đủ!',
                                    style: kLableW800White,
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackDemo);
                                return;
                              }

                              if (dateTimeController.isRoundTrip.value &&
                                  (dateTimeController.rangeEnd.value == null)) {
                                final snackDemo = SnackBar(
                                  content: Text(
                                    'Vui lòng chọn ngày về!',
                                    style: kLableW800White,
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackDemo);
                                return;
                              }
                              await dateTimeController.getDateList();
                              Get.to(const FlightListing());
                            },
                            child: Container(
                              height: 50,
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  'Tìm chuyến bay',
                                  style: kLableSize18White,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
