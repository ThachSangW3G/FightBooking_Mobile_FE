import 'package:flightbooking_mobile_fe/constants/app_colors.dart';
import 'package:flightbooking_mobile_fe/models/nav.dart';
import 'package:flightbooking_mobile_fe/screens/accounts/account_screen.dart';
import 'package:flightbooking_mobile_fe/screens/bottom_nav/nav_bar.dart';
import 'package:flightbooking_mobile_fe/screens/default_screen.dart';
import 'package:flightbooking_mobile_fe/screens/home/home_screen.dart';
import 'package:flightbooking_mobile_fe/screens/tickets/view_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final ticketKey = GlobalKey<NavigatorState>();
  final giftKey = GlobalKey<NavigatorState>();
  final accountKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = [
      NavModel(
        page: const HomeScreen(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const Scaffold(),
        navKey: ticketKey,
      ),
      NavModel(
        page: TicketScreenWidget(),
        navKey: giftKey,
      ),
      NavModel(
        page: const AccountScreen(),
        navKey: accountKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}
