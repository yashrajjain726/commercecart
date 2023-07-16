import 'package:commercecart/features/user/screens/payment/screens/payment_screen.dart';

import '../features/admin/screens/add_product/screens/add_product_screen.dart';

import '../common/widgets/admin_bottom_bar.dart';
import '../common/widgets/user_bottombar.dart';
import '../features/user/screens/address/screens/set_address_screen.dart';

import '../features/profile/screens/profile_screen.dart';
import '../features/auth/screens/login/screens/login_screen.dart';
import '../features/auth/screens/signup/screens/signup_screen.dart';
import '../features/user/screens/cart/screens/cart_screen.dart';
import '../features/user/screens/home/screens/category_screen.dart';
import '../features/user/screens/home/screens/home_screen.dart';
import '../features/no_page_found.dart';
import '../features/order/screens/order_detail_screen.dart';
import '../features/user/screens/product/screens/product_detail_screen.dart';
import '../features/user/screens/search/screens/search_screen.dart';
import '../models/orders.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  print(settings);
  switch (settings.name) {
    case LoginScreen.routeName:
      return buildRoute(screen: const LoginScreen());
    case SignUpScreen.routeName:
      return buildRoute(screen: const SignUpScreen());
    case AdminProfileScreen.routeName:
      return buildRoute(screen: const AdminProfileScreen());
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
    case PaymnentScreen.routeName:
      var amount = settings.arguments as double;
      return buildRoute(screen: PaymnentScreen(amount: amount));
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
