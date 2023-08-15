import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> login(String email, String password) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String loginUrl = 'http://localhost:8000/api/login/';
    final Map<String, String> data = {
      'username': email,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _token = responseData['token'];
      notifyListeners(); // Notify listeners about the token change
    } else {
      throw Exception('Login failed');
    }
    print(response.statusCode);
  }
}
