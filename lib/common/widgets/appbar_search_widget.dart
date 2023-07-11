import 'package:commercecart/features/cart/screens/cart_screen.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AppBarSearchWidget extends StatefulWidget {
  final bool? showCartButton;
  const AppBarSearchWidget({super.key, this.showCartButton = false});

  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int cartLength = context.watch<UserProvider>().user.cartList.length;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (value) => Navigator.pushNamed(
                    context, SearchScreen.routeName,
                    arguments: value),
                decoration: const InputDecoration(
                    hintText: 'Search appliances, mobiles and ...',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(top: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide(color: Colors.black38, width: 1),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(Icons.search, color: Colors.black, size: 23),
                    )),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 42,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Icon(
            Icons.mic,
            color: Colors.white,
            size: 25,
          ),
        ),
        (widget.showCartButton == true)
            ? GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                    context, CartScreen.routeName),
                child: badges.Badge(
                  badgeContent: Text(cartLength.toString()),
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.white),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
