import 'package:flightbooking_mobile_fe/components/homes/recent_search.dart';
import 'package:flightbooking_mobile_fe/components/homes/title_search.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/controllers/airport_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_styles.dart';

class BottomSheetDestinationPoint extends StatefulWidget {
  const BottomSheetDestinationPoint({super.key});

  @override
  State<BottomSheetDestinationPoint> createState() =>
      _BottomSheetDestinationPointState();
}

class _BottomSheetDestinationPointState
    extends State<BottomSheetDestinationPoint> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Chọn điểm đến',
                style: kLableSize20w700Black,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tìm tỉnh, thành phố",
                          hintStyle: kLableSize15Grey,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('assets/icons/search.svg'),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Thành phố hoặc sân bay phổ biến',
                      style: kLableSize18w700Black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const TitleSearch(title: 'HAN - Hà Nội, Việt Nam'),
              const TitleSearch(title: 'HAN - Hà Nội, Việt Nam'),
              const TitleSearch(title: 'HAN - Hà Nội, Việt Nam'),
              const TitleSearch(title: 'HAN - Hà Nội, Việt Nam'),
              const TitleSearch(title: 'HAN - Hà Nội, Việt Nam'),
            ],
          ),
        ),
      ),
    );
  }
}
