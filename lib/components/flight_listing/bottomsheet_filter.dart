import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomSheetFilter extends StatefulWidget {
  const BottomSheetFilter({super.key});

  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
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
                        Text(
                          'Số điểm dừng',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 13),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Text(
                                'Bay thẳng',
                                style: kLableSize15Black,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Text(
                                '1 điểm dừng',
                                style: kLableSize15Black,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Text(
                                '2+ điểm dừng',
                                style: kLableSize15Black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Giờ cất cánh',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi sáng sớm',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '00:00 - 06:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi sáng',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '06:00 - 12:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi chiều',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '12:00 - 18:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi tối',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '18:00 - 00:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Giờ hạ cánh',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi sáng sớm',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '00:00 - 06:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi sáng',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '06:00 - 12:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi chiều',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '12:00 - 18:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(color: AppColors.gray)),
                              child: Column(
                                children: [
                                  Text(
                                    'Buổi tối',
                                    style: kLableSize16ww600Black,
                                  ),
                                  Text(
                                    '18:00 - 00:00',
                                    style: kLableSize15Black,
                                  ),
                                ],
                              ),
                            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(value: true, onChanged: (value) {}),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/logo-vietjet.png'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'VietJet Air',
                                  style: kLableSize15Black,
                                )
                              ],
                            ),
                            Text(
                              'Từ 495k',
                              style: kLableSize20w700Black,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(value: true, onChanged: (value) {}),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/logo-vietjet.png'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'VietJet Air',
                                  style: kLableSize15Black,
                                )
                              ],
                            ),
                            Text(
                              'Từ 495k',
                              style: kLableSize20w700Black,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(value: true, onChanged: (value) {}),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/logo-vietjet.png'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'VietJet Air',
                                  style: kLableSize15Black,
                                )
                              ],
                            ),
                            Text(
                              'Từ 495k',
                              style: kLableSize20w700Black,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
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
                          'Hoàn tiền và đổi lịch bay',
                          style: kLableSize18w700Black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            Text(
                              'Được hoàn tiền',
                              style: kLableSize16ww600Black,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            Text(
                              'Có áp dụng đổi lịch',
                              style: kLableSize16ww600Black,
                            ),
                          ],
                        )
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
