import 'package:flightbooking_mobile_fe/components/homes/button_icon_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/controllers/datetime_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/passenger_controller.dart';
import 'package:flightbooking_mobile_fe/controllers/seat_class_controller.dart';
import 'package:flightbooking_mobile_fe/screens/home/find_flight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTrip = false;

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final PassengerController passengerController =
      Get.put(PassengerController());

  final SeatClassController seatClassController =
      Get.put(SeatClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            backgroundColor: AppColors.blue,
            leadingWidth: 60,
            leading: Container(
              decoration: const BoxDecoration(),
              child: Center(
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                      color: AppColors.slamon, shape: BoxShape.circle),
                ),
              ),
            ),
            actions: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0x34707070)),
                child: SvgPicture.asset('assets/icons/notification.svg'),
              ),
              const SizedBox(
                width: 10.0,
              )
            ],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: kLableMiniWhite,
                ),
                Text(
                  'Thach Sang',
                  style: kLableTitleWhite,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Positioned(
                    child: Container(
                      height: 200,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: AppColors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bạn muốn du lịch?',
                              style: kLableSize18White,
                            ),
                            Text(
                              'Đừng lo vì đã có Golobe',
                              style: kLableSize22White,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
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
                              offset: Offset(0, 3), // Thay đổi offset tùy ý
                            ),
                          ],
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
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
                                            Text(
                                              'Chọn điểm đi',
                                              style: kLableSize18Grey,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
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
                                            Text(
                                              'Chọn điểm đến',
                                              style: kLableSize18Grey,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/switch.svg',
                                height: 30,
                                width: 30,
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
                                      onTap: () => {showBottomSheetDate()},
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
                                    Row(
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
                                  showBottomSheePassenger();
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
                                  showBottomSheetSeatClass();
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
                            onTap: () {
                              Get.to(const FindFlight());
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

  Future showBottomSheetDate() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
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
                                          formatDateTime(dateTimeController
                                              .rangeStart.value),
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
                                          formatDateTime(dateTimeController
                                              .rangeEnd.value!),
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
                                formatDateTime(
                                    dateTimeController.rangeStart.value),
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
                                formatButtonVisible: false,
                                titleCentered: true),
                            availableGestures: AvailableGestures.all,
                          )
                        : TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: dateTimeController.rangeStart.value,
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                            availableGestures: AvailableGestures.all,
                            selectedDayPredicate: (day) {
                              return isSameDay(
                                  dateTimeController.rangeStart.value, day);
                            },
                            onDaySelected: dateTimeController.onDaySelected),
                  ),
                ],
              ));
        });
  }

  Future showBottomSheePassenger() {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 300,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Chọn hành khách',
                    style: kLableSize20w700Black,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/nguoilon.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Người lớn',
                                style: kLableSize18Black,
                              ),
                              Text(
                                'Từ 12 tuổi',
                                style: kLableSize18Grey,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                passengerController.reduceAdult();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/minus.svg')),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.gray)),
                            child: Center(
                                child: Obx(
                              () => Text(
                                passengerController.adult.value.toString(),
                                style: kLableSize18Black,
                              ),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () {
                                passengerController.increaseAdult();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/plus.svg'))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/treem.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trẻ em',
                                style: kLableSize18Black,
                              ),
                              Text(
                                'Từ 2 đến 11 tuổi',
                                style: kLableSize18Grey,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                passengerController.reduceChildren();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/minus.svg')),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.gray)),
                            child: Center(
                                child: Obx(
                              () => Text(
                                passengerController.children.value.toString(),
                                style: kLableSize18Black,
                              ),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () {
                                passengerController.increaseChildren();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/plus.svg'))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/embe.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Em bé',
                                style: kLableSize18Black,
                              ),
                              Text(
                                'Dưới 2 tuổi',
                                style: kLableSize18Grey,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                passengerController.reduceBabe();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/minus.svg')),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.gray)),
                            child: Center(
                                child: Obx(
                              () => Text(
                                passengerController.babe.value.toString(),
                                style: kLableSize18Black,
                              ),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () {
                                passengerController.increaseBabe();
                              },
                              child: const ButtonIconBlue(
                                  icon: 'assets/icons/plus.svg'))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future showBottomSheetSeatClass() {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 400,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Chọn hạng ghế',
                    style: kLableSize20w700Black,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.builder(
                      itemCount: seatClassController.seatClasses.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            seatClassController.setSelectedSeatClass(index);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          seatClassController
                                              .seatClasses[index].title,
                                          style: kLableSize18w700Black,
                                        ),
                                        Text(
                                          seatClassController
                                              .seatClasses[index].desc,
                                          maxLines: 2,
                                          style: kLableSize15w400Grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  Obx(() => Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        height: 30,
                                        width: 30,
                                        child: seatClassController
                                                    .selectedSeatClass.value ==
                                                index
                                            ? SvgPicture.asset(
                                                'assets/icons/checkselect.svg')
                                            : const SizedBox(),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
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
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }
}