import 'package:cached_network_image/cached_network_image.dart';
import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewWidgets extends StatelessWidget {
  final VoidCallback onPress;
  final String imageUrl;
  final String title;
  const ReviewWidgets(
      {super.key,
      required this.onPress,
      required this.imageUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: const BoxDecoration(
            border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: AppColors.gray),
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: 350,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  title,
                  style: kLableSize15Black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
