import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/airline_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/airport_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/flight_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/seat_class_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/sort_controller.dart';
import 'package:flightbooking_mobile_fe/models/airlines/airline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BottomSheetFilter extends StatefulWidget {
  const BottomSheetFilter({super.key});

  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  final AirlineController airlineController = Get.put(AirlineController());
  final FlightController flightController = Get.put(FlightController());
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final AirportController airportController = Get.put(AirportController());
  final SeatClassController seatClassController =
      Get.put(SeatClassController());
  final SortController sortController = Get.put(SortController());

  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (flightController.filterPriceMax.value > 0) {
      priceMaxController.text =
          flightController.filterPriceMax.value.toString();
    }

    if (flightController.filterPriceMin.value > 0) {
      priceMinController.text =
          flightController.filterPriceMin.value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.maxFinite,
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Lọc',
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
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        // Text(
                        //   'Số điểm dừng',
                        //   style: kLableSize18w700Black,
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 13),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Text(
                        //         'Bay thẳng',
                        //         style: kLableSize15Black,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Text(
                        //         '1 điểm dừng',
                        //         style: kLableSize15Black,
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Text(
                        //         '2+ điểm dừng',
                        //         style: kLableSize15Black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Text(
                        //   'Giờ cất cánh',
                        //   style: kLableSize18w700Black,
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi sáng sớm',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '00:00 - 06:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi sáng',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '06:00 - 12:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi chiều',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '12:00 - 18:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi tối',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '18:00 - 00:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Text(
                        //   'Giờ hạ cánh',
                        //   style: kLableSize18w700Black,
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi sáng sớm',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '00:00 - 06:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi sáng',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '06:00 - 12:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi chiều',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '12:00 - 18:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 170,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 7, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(15)),
                        //           border: Border.all(color: AppColors.gray)),
                        //       child: Column(
                        //         children: [
                        //           Text(
                        //             'Buổi tối',
                        //             style: kLableSize16ww600Black,
                        //           ),
                        //           Text(
                        //             '18:00 - 00:00',
                        //             style: kLableSize15Black,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10.0,
                        // ),

                        Text(
                          'Giá',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Từ',
                                  style: kLableSize16ww600Black,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: AppColors.gray)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextFormField(
                                        controller: priceMinController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Nhập giá'),
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: const ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              strokeAlign:
                                                  BorderSide.strokeAlignCenter,
                                              color: Color.fromARGB(
                                                  255, 204, 204, 208),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '₫',
                                        style: kLableSize16ww600Black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đến',
                                  style: kLableSize16ww600Black,
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: AppColors.gray)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextFormField(
                                        controller: priceMaxController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Nhập giá'),
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: const ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              strokeAlign:
                                                  BorderSide.strokeAlignCenter,
                                              color: Color.fromARGB(
                                                  255, 204, 204, 208),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '₫',
                                        style: kLableSize16ww600Black,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Hãng hàng không',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        FutureBuilder<List<Airline>>(
                            future: airlineController.getAllAirline(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final listAirline = snapshot.data;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: listAirline!.length,
                                  itemBuilder: (_, index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Checkbox(
                                              value: airlineController
                                                  .selectFilterAirline.value
                                                  .contains(
                                                      listAirline[index].id),
                                              onChanged: (value) {
                                                print(airlineController
                                                    .selectFilterAirline.value
                                                    .contains(
                                                        listAirline[index].id));
                                                if (!airlineController
                                                    .selectFilterAirline.value
                                                    .contains(listAirline[index]
                                                        .id)) {
                                                  airlineController
                                                      .addFilterAirline(
                                                          listAirline[index]
                                                              .id);
                                                } else {
                                                  airlineController
                                                      .removeFilterAirline(
                                                          listAirline[index]
                                                              .id);
                                                }

                                                print(airlineController
                                                    .selectFilterAirline.value);
                                              }),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      listAirline[index]
                                                          .logoUrl))),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          listAirline[index].airlineName,
                                          style: kLableSize15Black,
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                              return const SizedBox();
                            }),

                        const SizedBox(
                          height: 10.0,
                        ),

                        ButtonBlue(
                            des: 'Áp dụng',
                            onPress: () {
                              if (priceMaxController.text == '') {
                                flightController.setFilterPriceMax(0);
                              } else {
                                flightController.setFilterPriceMax(
                                    int.parse(priceMaxController.text));
                              }

                              if (priceMinController.text == '') {
                                flightController.setFilterPriceMin(0);
                              } else {
                                flightController.setFilterPriceMin(
                                    int.parse(priceMinController.text));
                              }

                              if (flightController.departureFlight.value ==
                                  null) {
                                flightController.filterFlights(
                                    dateTimeController.selectDate.value!,
                                    airportController
                                        .selectedDeparture.value!.id,
                                    airportController
                                        .selectedDestination.value!.id,
                                    seatClassController.selectedSeatClass.value,
                                    sortController.selectedSort.value,
                                    airlineController
                                        .selectFilterAirline.value);
                              } else {
                                flightController.filterFlights(
                                    dateTimeController.selectDate.value!,
                                    airportController
                                        .selectedDestination.value!.id,
                                    airportController
                                        .selectedDeparture.value!.id,
                                    seatClassController.selectedSeatClass.value,
                                    sortController.selectedSort.value,
                                    airlineController
                                        .selectFilterAirline.value);
                              }

                              Get.back();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
