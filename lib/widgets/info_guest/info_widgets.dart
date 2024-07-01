import 'package:flightbooking_mobile_fe/components/info_guest/choose_gender.dart';
import 'package:flightbooking_mobile_fe/components/info_guest/input_nationality.dart';
import 'package:flightbooking_mobile_fe/components/info_guest/input_text.dart';
import 'package:flightbooking_mobile_fe/components/info_guest/input_time.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';

class InfoGuestWidget extends StatefulWidget {
  const InfoGuestWidget({super.key});

  @override
  State<InfoGuestWidget> createState() => _InfoGuestWidgetState();
}

class _InfoGuestWidgetState extends State<InfoGuestWidget> {
  bool isExpandedInfo = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.dodger,
                borderRadius: !isExpandedInfo
                    ? const BorderRadius.all(Radius.circular(15))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  'Hành khách 1 - Người lớn',
                  style: kLableSize18White,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpandedInfo = !isExpandedInfo;
                    });
                  },
                  icon: Icon(
                      color: AppColors.white,
                      isExpandedInfo
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up),
                ),
              ],
            ),
          ),
          if (isExpandedInfo)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InputTextComponent(
                          label: 'Họ',
                          name: '',
                          hinttext: 'VD: Nguyễn',
                          onChanged: (value) {}),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InputTextComponent(
                          label: 'Tên và tên đệm',
                          name: '',
                          hinttext: 'VD: Trung Tinh',
                          onChanged: (value) {}),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InputTimePicker(
                          label: 'Ngày sinh',
                          name: '',
                          hinttext: 'dd/mm/yyyy',
                          onChanged: (value) {})
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputNationality(des: 'Quốc tịch', onChange: (value) {}),
                  const SizedBox(
                    height: 10,
                  ),
                  ChooseGender(onChange: (value) {
                    print(value.toString());
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      InputTextComponent(
                          label: 'Số hộ chiếu',
                          name: '',
                          hinttext: 'VD: C635374674',
                          onChanged: (value) {}),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputNationality(des: 'Quốc tịch', onChange: (value) {}),
                ],
              ),
            )
        ],
      ),
    );
  }
}
