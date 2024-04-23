import 'package:flightbooking_mobile_fe/components/flight_listing/bottomsheet_filter.dart';
import 'package:flightbooking_mobile_fe/components/flight_listing/bottomsheet_sort.dart';
import 'package:flightbooking_mobile_fe/components/flight_listing/flight_item.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/sort_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/datetime_controller.dart';

class FlightListing extends StatefulWidget {
  const FlightListing({super.key});

  @override
  State<FlightListing> createState() => _FlightListingState();
}

class _FlightListingState extends State<FlightListing> {
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  bool isEmpty = false;

  int selectDate = 0;

  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final SortController sortController = Get.put(SortController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        centerTitle: false,
        backgroundColor: AppColors.blue,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(193, 201, 195, 195)),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset('assets/icons/arrowleft.svg'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Chuyến đi SGN - HAN',
              style: kLableTitleWhite,
            )
          ],
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(193, 201, 195, 195)),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset('assets/icons/more.svg'),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.maxFinite,
            decoration: const BoxDecoration(color: AppColors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/planeup.svg',
                  color: AppColors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '4 khách - Economy',
                  style: kLableSize18White,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white,
                        )),
                    child: SvgPicture.asset('assets/icons/arrowdown.svg'))
              ],
            ),
          ),
          Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dateTimeController.listDate.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectDate = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: selectDate == index
                                    ? AppColors.blue
                                    : AppColors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Thứ 3',
                                  style: selectDate == index
                                      ? kLableSize18w700White
                                      : kLableSize18w700Black,
                                ),
                                Text(
                                  formatDateTime(
                                      dateTimeController.listDate[index]),
                                  style: selectDate == index
                                      ? kLableSize15White
                                      : kLableSize15Grey,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
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
                          width: 10,
                        ),
                      ],
                    );
                  })),
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
          Container(
            width: double.maxFinite,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => const BottomSheetFilter());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: AppColors.gray)),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/filter.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Lọc',
                          style: kLableSize18Black,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => const BottomSheetSort());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: AppColors.blue)),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/switch.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(() => Text(
                              sortController
                                  .sorts[sortController.selectedSort.value]
                                  .title,
                              style: kLableSize18w500Bule,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(color: AppColors.whisper),
              child: isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Container(
                            height: 150,
                            width: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/empty.png'))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Không tìm thấy chuyến bay',
                            style: kLableSize20w700Black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Xin vui lòng chọn tìm kiếm khác',
                            style: kLableSize18Black,
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Giá hiển thị đã bao gồm thuế và phí',
                            style: kLableSize15w400Grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const FlightItem(),
                          const FlightItem(),
                          const FlightItem(),
                          const FlightItem(),
                          const FlightItem(),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
