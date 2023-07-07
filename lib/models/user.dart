// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String token;
  final String type;
  final String address;
  final List<dynamic> cartList;
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.token,
    required this.type,
    required this.address,
    required this.cartList,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_id': id});
    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'password': password});
    result.addAll({'token': token});
    result.addAll({'type': type});
    result.addAll({'address': address});
    result.addAll({'cart': cartList});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      address: map['address'] ?? '',
      cartList: List<Map<String, dynamic>>.from(
          map['cart']?.map((x) => Map<String, dynamic>.from(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? password,
    String? token,
    String? type,
    String? address,
    List<dynamic>? cartList,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      token: token ?? this.token,
      type: type ?? this.type,
      address: address ?? this.address,
      cartList: cartList ?? this.cartList,
    );
  }
}
