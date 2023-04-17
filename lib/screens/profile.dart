import 'package:flutter/material.dart';

import '../controller/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Username: ${user.username}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Name: ${user.firstName} ${user.lastName}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // handle request donation button press
              },
              child: Text('Request Donation'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // handle donation history button press
              },
              child: Text('Donation History'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // handle e-certificate button press
              },
              child: Text('E-Certificate'),
            ),
          ],
        ),
      ),
    );
  }
}
