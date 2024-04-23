import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_styles.dart';
import '../../controllers/seat_class_controller.dart';

class BottomSeatClass extends StatefulWidget {
  const BottomSeatClass({super.key});

  @override
  State<BottomSeatClass> createState() => _BottomSeatClassState();
}

class _BottomSeatClassState extends State<BottomSeatClass> {
  final SeatClassController seatClassController =
      Get.put(SeatClassController());

  @override
  Widget build(BuildContext context) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    seatClassController
                                        .seatClasses[index].title,
                                    style: kLableSize18w700Black,
                                  ),
                                  Text(
                                    seatClassController.seatClasses[index].desc,
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
  }
}
