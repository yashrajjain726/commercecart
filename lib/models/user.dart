import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String token;
  final String type;
  final String address;
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.token,
    required this.type,
    required this.address,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
