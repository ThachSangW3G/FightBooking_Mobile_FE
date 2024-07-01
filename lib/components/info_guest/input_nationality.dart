import 'package:country_list_pick/country_list_pick.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';

class InputNationality extends StatefulWidget {
  final String des;
  final ValueChanged<String> onChange;
  const InputNationality(
      {super.key, required this.des, required this.onChange});

  @override
  State<InputNationality> createState() => _InputNationalityState();
}

class _InputNationalityState extends State<InputNationality> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.des,
          style: kLableSize18w700Black,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Expanded(
                  child: CountryListPick(
                appBar: AppBar(
                  backgroundColor: AppColors.dodger,
                  title: Text(
                    'Pick your country',
                    style: kLableSize18w700White,
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // if you need custom picker use this
                // pickerBuilder: (context, CountryCode? countryCode) {
                //   return Container(
                //     height: 40,
                //     decoration: BoxDecoration(
                //         border: Border.all(color: AppColors.gray)),
                //     child: Row(
                //       children: [
                //         Image.asset(
                //           countryCode!.flagUri.toString(),
                //           package: 'country_list_pick',
                //         ),
                //         Text(countryCode.code.toString()),
                //         Text(countryCode.dialCode.toString()),
                //       ],
                //     ),
                //   );
                // },
                theme: CountryTheme(
                  isShowFlag: true,
                  isShowTitle: true,
                  isShowCode: true,
                  isDownIcon: true,
                  showEnglishName: false,
                  labelColor: Colors.blueAccent,
                ),
                initialSelection: '+84',
                // or
                // initialSelection: 'US'
                onChanged: (CountryCode? code) {
                  widget.onChange(code!.dialCode.toString());
                },
                // Whether to allow the widget to set a custom UI overlay
              )),
            )
          ],
        ),
      ],
    );
  }
}
