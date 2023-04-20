import 'dart:convert';
import 'package:http/http.dart' as http;

class BloodApi {
  static const baseUrl = 'http://127.0.0.1:5000/blooddata';

  static Future<Map<String, dynamic>> getBloodStock() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print(
          'API returned status code ${response.statusCode}: ${response.reasonPhrase}');
      throw Exception('Failed to fetch data');
      throw Exception('Failed to fetch data');
    }
  }
}
