// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:commercecart/common/widgets/bottombar.dart';
import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:commercecart/features/home/screens/home_screen.dart';
import 'package:commercecart/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          token: '',
          type: '',
          address: '');
      http.Response response = await http.post(
        Uri.parse('${Globals.URI}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print(response.body);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Account Created, Login with Credentials');
          });
    } catch (e) {
      print(e);
      showSnackbar(context, e.toString());
    }
  }

  Future<void> sigInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
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
      print(response.body);
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await preferences.setString(
                Globals.AUTHTOKEN, jsonDecode(response.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(Globals.AUTHTOKEN);
      if (token == null) {
        await preferences.setString(Globals.AUTHTOKEN, '');
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
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
