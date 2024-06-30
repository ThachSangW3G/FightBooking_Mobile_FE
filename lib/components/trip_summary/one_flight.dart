import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/models/flights/flight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OnFlight extends StatelessWidget {
  final Flight flight;
  final VoidCallback onTapDetails;
  final VoidCallback onPressButton;
  const OnFlight(
      {super.key,
      required this.onTapDetails,
      required this.onPressButton,
      required this.flight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                          DateFormat('HH:mm').format(flight.departureDate),
                          style: kLableSize18w700Black,
                        ),
                        Text(
                          'SGN',
                          style: kLableSize13Black,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(flight.departureDate),
                          style: kLableSize13Black,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '1g 15p',
                          style: kLableSize15Grey,
                        ),
                        SizedBox(
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
                          DateFormat('HH:mm').format(flight.arrivalDate),
                          style: kLableSize18w700Black,
                        ),
                        Text(
                          'HAN',
                          style: kLableSize13Black,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(flight.arrivalDate),
                          style: kLableSize13Black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Vietjet Air - Economy',
                    style: kLableSize15Black,
                  )
                ],
              ),
              GestureDetector(
                onTap: onTapDetails,
                child: Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 211, 211, 214),
                        )),
                    child: SvgPicture.asset('assets/icons/arrowdown.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.gray, BlendMode.srcIn))),
              )
            ],
          ),
          ButtonBlue(des: 'Đổi hạng ghế', onPress: onPressButton)
        ],
      ),
    );
  }
}
