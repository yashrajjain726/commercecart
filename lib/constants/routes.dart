import 'package:commercecart/common/widgets/admin_bottom_bar.dart';
import 'package:commercecart/common/widgets/user_bottombar.dart';
import 'package:commercecart/features/address/screens/address_screen.dart';
import 'package:commercecart/features/address/screens/confirm_address_screen.dart';
import 'package:commercecart/features/admin/screens/add_product_screen.dart';
import 'package:commercecart/features/auth/screens/login_screen.dart';
import 'package:commercecart/features/auth/screens/signup_screeen.dart';
import 'package:commercecart/features/cart/screens/cart_screen.dart';
import 'package:commercecart/features/home/screens/category_screen.dart';
import 'package:commercecart/features/home/screens/home_screen.dart';
import 'package:commercecart/features/no_page_found.dart';
import 'package:commercecart/features/order/screens/order_detail_screen.dart';
import 'package:commercecart/features/product/screens/product_detail_screen.dart';
import 'package:commercecart/features/search/screens/search_screen.dart';
import 'package:commercecart/models/orders.dart';
import 'package:commercecart/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  print(settings);
  switch (settings.name) {
    case LoginScreen.routeName:
      return buildRoute(screen: const LoginScreen());
    case SignUpScreen.routeName:
      return buildRoute(screen: const SignUpScreen());
    case HomeScreen.routeName:
      return buildRoute(screen: const HomeScreen());
    case UserBottomBar.routeName:
      return buildRoute(screen: const UserBottomBar());
    case AdminBottomBar.routeName:
      return buildRoute(screen: const AdminBottomBar());
    case AddProductScreen.routeName:
      return buildRoute(screen: const AddProductScreen());
    case CategoryScreen.routeName:
      var category = settings.arguments as String;
      return buildRoute(screen: CategoryScreen(category: category));
    case SearchScreen.routeName:
      var query = settings.arguments as String;
      return buildRoute(screen: SearchScreen(query: query));
    case ProductDetailScreen.routeName:
      var product = settings.arguments as Product;
      return buildRoute(screen: ProductDetailScreen(product: product));
    case CartScreen.routeName:
      return buildRoute(screen: const CartScreen());
    case AddressScreen.routeName:
      return buildRoute(screen: const AddressScreen());
    case ConfirmAddressScreen.routeName:
      var amount = settings.arguments as double;
      return buildRoute(screen: ConfirmAddressScreen(amount: amount));
    case OrderDetailScreen.routeName:
      var order = settings.arguments as OrdersModel;
      return buildRoute(screen: OrderDetailScreen(order: order));
    default:
      return buildRoute(screen: const NoPageFound());
  }
}

buildRoute({required Widget screen}) {
  return MaterialPageRoute(builder: (_) => screen);
}
