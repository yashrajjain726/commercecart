import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/features/account/screens/account_screen.dart';
import 'package:commercecart/features/home/screens/home_screen.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class UserBottomBar extends StatefulWidget {
  static const routeName = '/main-home-page';
  const UserBottomBar({super.key});

  @override
  State<UserBottomBar> createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart Page'))
  ];
  @override
  Widget build(BuildContext context) {
    int cartLength = context.watch<UserProvider>().user.cartList.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _updatePage,
        items: [
          // HOME
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

          // ACCOUNT
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
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ""),

          //CART
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
                child: badges.Badge(
                  badgeContent: Text(cartLength.toString()),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              label: "")
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
