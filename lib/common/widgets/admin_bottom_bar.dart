import '../../features/admin/screens/orders_received/screens/orders_received_screen.dart';
import '../../features/admin/screens/product_listing/screens/product_listing_screen.dart';

import '../../constants/globals.dart';
import '../../features/common/profile/screens/profile_screen.dart';
import '../../features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../features/admin/screens/earning_analytics/screens/earning_analytics_screen.dart';

class AdminBottomBar extends StatefulWidget {
  static const routeName = '/admin-home-page';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  final AuthService authService = AuthService();
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const ProductListingScreen(),
    const EarningAnalyticsScreen(),
    const OrdersReceivedScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Globals.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: const Text('CommerceCart')),
                  const Text(
                    'Admin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, AdminProfileScreen.routeName),
                      icon: const Icon(Icons.person_2)),
                  IconButton(
                      onPressed: () => authService.logout(context),
                      icon: const Icon(Icons.logout_outlined))
                ],
              ),
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _updatePage,
        items: [
          // POSTS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: bottomBarBorderWidth,
                            color: _page == 0
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ""),

          // ANALYTICS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: bottomBarBorderWidth,
                            color: _page == 1
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor))),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ""),

          //ORDERS
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: bottomBarBorderWidth,
                            color: _page == 2
                                ? Globals.selectedNavBarColor
                                : Globals.backgroundColor))),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ""),
        ],
        currentIndex: _page,
        selectedItemColor: Globals.selectedNavBarColor,
        unselectedItemColor: Globals.unselectedNavBarColor,
        backgroundColor: Globals.backgroundColor,
        iconSize: 28,
      ),
    );
  }

  void _updatePage(int value) {
    setState(() {
      _page = value;
    });
  }
}
