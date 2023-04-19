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
  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(
        Uri.parse('https://rakthaseva.onrender.com/bloodReq/${widget.user}'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body)['user_data'];
      });
      return userData;
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
            return ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                var data = userData.values.toList()[index];
                return ListTile(
                  title: Text(data['name'] ?? 'N/A'),
                  subtitle: Text(data['gender'] ?? 'N/A'),
                  trailing: Text(data['bloodGroup'] ?? 'N/A'),
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
