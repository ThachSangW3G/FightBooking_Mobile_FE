import 'package:flightbooking_mobile_fe/components/info_guest/input_text.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/components/trip_summary/price_details.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/checkout_screen.dart';
import 'package:flightbooking_mobile_fe/widgets/info_guest/info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InfoGuestScreen extends StatefulWidget {
  const InfoGuestScreen({super.key});

  @override
  State<InfoGuestScreen> createState() => _InfoGuestScreenState();
}

class _InfoGuestScreenState extends State<InfoGuestScreen> {
  final List<Map<String, dynamic>> flightPrice = [
    {
      'adults': 2,
      'children': 1,
      'infants': 1,
      'priceAdult': 100,
      'priceChild': 80,
      'priceInfant': 40,
      'totalPrice': 220,
      'disCount': 200000,
      'priceTax': 100000,
      'priceLuggage': 200000,
      'priceProcedure': 100000,
      'type': 'go',
      'start': 'HN',
      'end': 'SG',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Thông tin hành khách', style: kLableSize20w700White),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5FA),
      body: Stack(fit: StackFit.expand, children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoGuestWidget(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Thông tin liên hệ',
                          style: kLableSize20w700Black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InputTextComponent(
                                label: 'Tên',
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
                            InputTextComponent(
                                label: 'Số điện thoại',
                                name: '',
                                hinttext: '0704408389',
                                onChanged: (value) {}),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InputTextComponent(
                                label: 'Email',
                                name: '',
                                hinttext: 'trungtinhh1620@gmail.com',
                                onChanged: (value) {}),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: AppColors.white,
            height: 130.0, // Adjust the height as needed
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng số tiền', style: kLableSize18w700Black),
                      Row(
                        children: [
                          Text(
                            '7.800.000 đ',
                            style: kLableSize18w500Bule,
                          ),
                          IconButton(
                              onPressed: () {
                                if (flightPrice.length > 1) {
                                  showPriceDetails(true);
                                } else {
                                  showPriceDetails(false);
                                }
                              },
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                color: AppColors.gray,
                              ))
                        ],
                      ),
                    ],
                  ),
                  ButtonBlue(
                      des: 'Tiếp tục',
                      onPress: () {
                        Get.to(() => const CheckoutScreen());
                      })
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future showPriceDetails(bool isScroll) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: isScroll,
        builder: (_) {
          return _buildPriceList();
        });
  }

  Widget _buildPriceList() {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0), // Add space above "Chi tiết đơn hàng"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 25,
              ),
              Text(
                'Chi tiết giá',
                style: kLableSize20w700Black,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(),
          if (true)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: flightPrice.length,
              itemBuilder: (context, index) {
                final flightPrices = flightPrice[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15.0), // Add padding bottom
                  child: PriceDetails(
                    adults: flightPrices['adults'] ?? 0,
                    children: flightPrices['children'] ?? 0,
                    infants: flightPrices['infants'] ?? 0,
                    priceAdult: flightPrices['priceAdult'] ?? 0,
                    priceChild: flightPrices['priceChild'] ?? 0,
                    priceInfant: flightPrices['priceInfant'] ?? 0,
                    totalPrice: flightPrices['totalPrice'] ?? 0,
                    disCount: flightPrices['disCount'] ?? 0,
                    priceTax: flightPrices['priceTax'] ?? 0,
                    priceLuggage: flightPrices['priceLuggage'] ?? 0,
                    priceProcedure: flightPrices['priceProcedure'] ?? 0,
                    type: flightPrices['type'] ?? '',
                    start: flightPrices['start'] ?? '',
                    end: flightPrices['end'] ?? '',
                  ),
                );
              },
            ),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 130.0, // Adjust the height as needed
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tổng số tiền', style: kLableSize18w700Black),
                    Text(
                      '7.800.000 đ',
                      style: kLableSize18w500Bule,
                    ),
                  ],
                ),
                ButtonBlue(
                    des: 'Tiếp tục',
                    onPress: () {
                      Get.to(() => const CheckoutScreen());
                    })
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
