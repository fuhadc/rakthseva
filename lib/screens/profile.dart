import 'package:flutter/material.dart';
import '../controller/user.dart';
import 'certificate.dart';

class ProfilePage extends StatefulWidget {
  final dynamic user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Account Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Name'),
            subtitle: Text(widget.user.username),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text(widget.user.email),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                Switch(
                  value: _isDarkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isDarkModeEnabled = value;
                    });
                    // TODO: Implement dark mode functionality
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // navigate to your request page
                },
                child: Text('Your Request'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Donation History'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfList(
                          userId: widget.user.userid,
                        ),
                      ));
                },
                child: Text('E-Certificate'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
