import 'package:flightbooking_mobile_fe/components/flight_listing/flight_item.dart';
import 'package:flightbooking_mobile_fe/components/login_signup/button_blue.dart';
import 'package:flightbooking_mobile_fe/components/trip_summary/one_flight.dart';
import 'package:flightbooking_mobile_fe/components/trip_summary/price_details.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flightbooking_mobile_fe/screens/checkout/widgets/checkout/flight_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TripSummary extends StatefulWidget {
  const TripSummary({super.key});

  @override
  State<TripSummary> createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  int _valueTickets = 2;
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
  final List<Map<String, dynamic>> listEconomy = [
    {'type': 'life', 'price': 0},
    {'type': 'classic', 'price': 100000},
    {'type': 'flex', 'price': 20000}
  ];
  final List<Map<String, dynamic>> listBusiness = [
    {'type': 'SkyBoss', 'price': 1300000},
    {'type': 'Flex', 'price': 100000},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dodger,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text('Tóm tắt đặt chỗ', style: kLableSize20w700White),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5FA),
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Text('Chuyến đi: Hồ Chí Minh - Hà Nội',
                  style: kLableSize18w700Black),
            ),
            OnFlight(
              onTapDetails: () {},
              onPressButton: () {
                showChooseTickets();
              },
            )
          ],
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
                  ButtonBlue(des: 'Tiếp tục', onPress: () {})
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
                ButtonBlue(des: 'Tiếp tục', onPress: () {})
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Future showChooseTickets() {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return _buildTicketsList();
        });
  }

  Widget _buildTicketsList() {
    return Column(
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
              'Chọn hạng ghế',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Economy',
                style: kLableSize20w700Black,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listEconomy.length,
                itemBuilder: (context, index) {
                  final oneEconomy = listEconomy[index];
                  String des = oneEconomy['type'] ?? '';
                  int price = oneEconomy['price'] ?? '';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: index + 1,
                              activeColor: AppColors.dodger,
                              groupValue: _valueTickets,
                              onChanged: (value) {
                                setState(() {
                                  _valueTickets = value ?? 0;
                                });
                              }),
                          Text(
                            'Economy $des',
                            style: kLableSize16Black,
                          )
                        ],
                      ),
                      Text(
                        '+$price đ / người',
                        style: kLableSize18w500Bule,
                      )
                    ],
                  );
                },
              ),
              Text(
                'Business',
                style: kLableSize20w700Black,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listBusiness.length,
                itemBuilder: (context, index) {
                  final oneBusiness = listBusiness[index];
                  String des = oneBusiness['type'] ?? '';
                  int price = oneBusiness['price'] ?? '';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: index + 1 + listEconomy.length,
                              activeColor: AppColors.dodger,
                              groupValue: _valueTickets,
                              onChanged: (value) {
                                setState(() {
                                  _valueTickets = value ?? 0;
                                });
                              }),
                          Text(
                            des,
                            style: kLableSize16Black,
                          )
                        ],
                      ),
                      Text(
                        '+$price đ / người',
                        style: kLableSize18w500Bule,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
