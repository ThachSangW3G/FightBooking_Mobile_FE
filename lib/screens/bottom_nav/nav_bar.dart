import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;
  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: [
              navItem(
                'assets/svgs/home.svg',
                pageIndex == 0,
                'Home',
                onTap: () => onTap(0),
              ),
              navItem(
                'assets/svgs/shopping-bag.svg',
                pageIndex == 1,
                'Explore',
                onTap: () => onTap(1),
              ),
              navItem(
                'assets/svgs/ticket.svg',
                pageIndex == 2,
                'My ticket',
                onTap: () => onTap(2),
              ),
              navItem(
                'assets/svgs/user.svg',
                pageIndex == 3,
                'My profile',
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget navItem(String icon, bool selected, String title, {Function()? onTap}) {
  return Expanded(
    child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: selected ? AppColors.blue : AppColors.stack,
            ),
            Text(
              title,
              style: selected ? kLableSize16ww600Blue : kLableSize16ww600Stack,
            )
          ],
        )),
  );
}
