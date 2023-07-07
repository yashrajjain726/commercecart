import 'package:commercecart/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    name: '',
    password: '',
    token: '',
    type: '',
    address: '',
    cartList: [],
  );

  User get user => _user;

  setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  setUserfromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
