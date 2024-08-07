import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/airline_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/airport_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/seat_class_controller.dart';
import 'package:flightbooking_mobile_fe/models/airlines/airline.dart';
import 'package:flightbooking_mobile_fe/models/airports/airport.dart';
import 'package:flightbooking_mobile_fe/models/flights/flight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FlightItem extends StatefulWidget {
  final Flight flight;
  final bool? isSelected;
  final Function()? onTap;
  final Function()? onClose;
  const FlightItem(
      {super.key,
      required this.flight,
      this.onTap,
      this.isSelected,
      this.onClose});

  @override
  State<FlightItem> createState() => _FlightItemState();
}

class _FlightItemState extends State<FlightItem> {
  final AirportController airportController = Get.put(AirportController());
  final SeatClassController seatClassController =
      Get.put(SeatClassController());
  final AirlineController airlineController = Get.put(AirlineController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Thay đổi offset tùy ý
              ),
            ],
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            DateFormat('HH:mm')
                                .format(widget.flight.departureDate),
                            style: kLableSize18w700Black,
                          ),
                          FutureBuilder(
                              future: airportController.getAirportById(
                                  widget.flight.departureAirportId),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                return Text(
                                  snapshot.data?.iataCode ?? '',
                                  style: kLableSize15Black,
                                );
                              }),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${widget.flight.duration}h',
                            style: kLableSize15Grey,
                          ),
                          Container(
                            width: 100,
                            child: SvgPicture.asset('assets/icons/vector.svg'),
                          ),
                          Text(
                            'Bay thẳng',
                            style: kLableSize15Grey,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            DateFormat('HH:mm')
                                .format(widget.flight.arrivalDate),
                            style: kLableSize18w700Black,
                          ),
                          FutureBuilder(
                              future: airportController.getAirportById(
                                  widget.flight.arrivalAirportId),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                return Text(
                                  snapshot.data?.iataCode ?? '',
                                  style: kLableSize15Black,
                                );
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '${seatClassController.selectedSeatClass.value == 0 ? widget.flight.economyPrice.toString() : seatClassController.selectedSeatClass.value == 1 ? widget.flight.businessPrice.toString() : widget.flight.firstClassPrice.toString()}\$',
                  style: kLableSize20w700Bule,
                )
              ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<Airline>(
                    future: airlineController.getAirline(
                        planeId: widget.flight.planeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      }

                      final airline = snapshot.data!;
                      return Row(
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(airline.logoUrl))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            airline.airlineName,
                            style: kLableSize15Black,
                          )
                        ],
                      );
                    }),
                widget.isSelected != null && widget.isSelected == true
                    ? InkWell(
                        onTap: widget.onClose,
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.gray,
                                )),
                            child: const Center(
                                child:
                                    Icon(Icons.close, color: AppColors.gray))),
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
