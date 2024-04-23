import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlightItem extends StatefulWidget {
  const FlightItem({super.key});

  @override
  State<FlightItem> createState() => _FlightItemState();
}

class _FlightItemState extends State<FlightItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                          '07:45',
                          style: kLableSize18w700Black,
                        ),
                        Text(
                          'SGN',
                          style: kLableSize15Black,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '1g 15p',
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
                          '09:00',
                          style: kLableSize18w700Black,
                        ),
                        Text(
                          'HAN',
                          style: kLableSize15Black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '2.500.000 ₫',
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
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/logo-vietjet.png'))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Vietjet Air - Economy',
                    style: kLableSize15Black,
                  )
                ],
              ),
              Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.gray,
                      )),
                  child: SvgPicture.asset('assets/icons/arrowdown.svg',
                      color: AppColors.gray))
            ],
          )
        ],
      ),
    );
  }
}
