import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user.dart';


class AuthService {
  final String apiUrl = 'https://example.com/api';

  Future<bool> login(BuildContext context, User user) async {
    final response = await http.post(Uri.parse('$apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userId = data['user_id']; // Extract the user ID from the response
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId); // Store the user ID in shared preferences

      Navigator.of(context).pushReplacementNamed('/home', arguments: userId); // Navigate to the home page with the user ID as argument
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid username or password'),
        duration: Duration(seconds: 3),
      ));
      return false;
    }
  }

  Future<bool> register(BuildContext context, User user) async {
    final response = await http.post(Uri.parse('$apiUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()));

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final userId = data['user_id']; // Extract the user ID from the response
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId); // Store the user ID in shared preferences

      Navigator.of(context).pushReplacementNamed('/home', arguments: userId); // Navigate to the home page with the user ID as argument
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration failed'),
        duration: Duration(seconds: 3),
      ));
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the stored user ID from shared preferences
    Navigator.of(context).pushReplacementNamed('/login'); // Navigate back to the login page
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId'); // Retrieve the stored user ID from shared preferences
  }
}
