import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  final String userId;

  NotificationPage({required this.userId});

  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<NotificationPage> {
  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(
        Uri.parse('https://rakthaseva.onrender.com/message/${widget.userId}'));

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
        title: Text('Notification Page Screen'),
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
                  title: Text(data['title'] ?? 'N/A'),
                  subtitle: Text(data['body'] ?? 'N/A'),
                  trailing: Text(data['date'] ?? 'N/A'),
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
