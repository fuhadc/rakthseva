import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BloodRequestScreen extends StatefulWidget {
  final String user;

  BloodRequestScreen({required this.user});

  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.11:5555/bloodReq/${widget.user}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Request Screen'),
      ),
      body: FutureBuilder(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? userData = snapshot.data?['user_data'];

            return ListView.builder(
              itemCount: userData?.length ?? 0,
              itemBuilder: (context, index) {
                var data = userData?.values.toList()[index];
                return ListTile(
                  title: Text(data?['name'] ?? 'N/A'),
                  subtitle: Text(data?['gender'] ?? 'N/A'),
                  trailing: Text(data?['bloodGroup'] ?? 'N/A'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
