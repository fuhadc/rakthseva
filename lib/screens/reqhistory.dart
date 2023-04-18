import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserPage extends StatefulWidget {
  final String user;
  const UserPage({super.key, required this.user});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Map<String, dynamic> userData;

  Future<void> _fetchUserData() async {
    String url = 'http://192.168.1.11:5555/bloodReq/${widget.user}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      print('Failed to fetch user data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                var data = userData.values.toList()[index];
                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['gender']),
                  trailing: Text(data['bloodGroup']),
                );
              },
            ),
    );
  }
}
