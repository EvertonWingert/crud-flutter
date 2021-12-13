import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  final baseUrl = 'http://10.0.2.2:8000/api/';
  final client = http.Client();

  Future login(email, password) async {
    final response = await client.post(
      Uri.parse(baseUrl + 'login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return json.decode(response.body);
  }

  Future register(email, password) async {
    final response = await client.post(
      Uri.parse(baseUrl + 'register'),
      body: {
        'email': email,
        'password': password,
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    return json.decode(response.body);
  }
}
