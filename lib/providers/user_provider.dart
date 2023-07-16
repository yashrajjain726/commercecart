import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  int userbottomBarIndex = 0;
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

  setBottomBarIndex(int value) {
    userbottomBarIndex = value;
    notifyListeners();
  }
}
