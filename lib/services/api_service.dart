import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String apiKey = ''; // Movie Database Api Key
  String baseUrl = ''; // Movie Database Base URL

  Future<String> loginResponse(String email, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://reqres.in/api/login"),
          body: {"email": email, "password": password});

      var jsonResp = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'success';
      } else {
        return jsonResp['error'];
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }
}
