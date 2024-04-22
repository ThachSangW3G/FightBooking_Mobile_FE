import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_styles.dart';
import '../../controllers/passenger_controller.dart';
import 'button_icon_blue.dart';

class BottomSheetPassenger extends StatefulWidget {
  const BottomSheetPassenger({super.key});

  @override
  State<BottomSheetPassenger> createState() => _BottomSheetPassengerState();
}

class _BottomSheetPassengerState extends State<BottomSheetPassenger> {
  final PassengerController passengerController =
      Get.put(PassengerController());
  @override
  Widget build(BuildContext context) {
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
                        child:
                            const ButtonIconBlue(icon: 'assets/icons/plus.svg'))
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
                        child:
                            const ButtonIconBlue(icon: 'assets/icons/plus.svg'))
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
                        child:
                            const ButtonIconBlue(icon: 'assets/icons/plus.svg'))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
