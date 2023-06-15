// ignore_for_file: use_build_context_synchronously

import 'package:commercecart/constants/globals.dart';
import 'package:commercecart/constants/utils.dart';
import 'package:commercecart/features/auth/services/http_error_handler.dart';
import 'package:flutter/material.dart';

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
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Account Created, Login with Credentials');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
