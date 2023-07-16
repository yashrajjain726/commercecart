// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:commercecart/common/ui_widgets/loader.dart';
import 'package:commercecart/common/widgets/admin_bottom_bar.dart';
import 'package:commercecart/common/widgets/user_bottombar.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/screens/login/screens/login_screen.dart';
import 'package:commercecart/common/services/http_error_handler.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:commercecart/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AppSharedPreference preference = AppSharedPreference();
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      Loader().showLoadingDialog(context);
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          token: '',
          type: '',
          address: '',
          cartList: []);
      http.Response response = await http.post(
        Uri.parse('${Globals.URI}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print(response.body);
      Loader().closeLoadingDialog(context);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Account Created, Login with Credentials');
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
    } catch (e) {
      Loader().closeLoadingDialog(context);
      print(e);
      showSnackbar(context, e.toString());
    }
  }

  Future<void> sigInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      Loader().showLoadingDialog(context);
      http.Response response = await http.post(
        Uri.parse('${Globals.URI}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      Loader().closeLoadingDialog(context);
      print(response.body);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            context.read<UserProvider>().setUser(response.body);
            preference.setUserToken(
                Globals.AUTHTOKEN, jsonDecode(response.body)['token']);
          });
      context.read<UserProvider>().setBottomBarIndex(0);
      (jsonDecode(response.body)['type'] == "user")
          ? Navigator.pushReplacementNamed(context, UserBottomBar.routeName)
          : (jsonDecode(response.body)['type'] == "admin")
              ? Navigator.pushReplacementNamed(
                  context, AdminBottomBar.routeName)
              : null;
    } catch (e) {
      Loader().closeLoadingDialog(context);
      showSnackbar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      String? token = await preference.getUserToken(Globals.AUTHTOKEN);
      if (token == null) {
        await preference.setUserToken(Globals.AUTHTOKEN, '');
      }
      final tokenResponse = await http.post(
        Uri.parse('${Globals.URI}/api/validate/token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      print(tokenResponse.body);
      var response = jsonDecode(tokenResponse.body);
      if (response == true) {
        http.Response userResponse = await http
            .get(Uri.parse('${Globals.URI}/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        });
        context.read<UserProvider>().setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      Loader().showLoadingDialog(context);
      await preference.setUserToken(Globals.AUTHTOKEN, "");
      Loader().closeLoadingDialog(context);
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    } catch (e) {
      Loader().closeLoadingDialog(context);
      showSnackbar(context, e.toString());
    }
  }
}
