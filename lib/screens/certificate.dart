import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../controller/pdf.dart';

class PdfList extends StatelessWidget {
  final String userId;

  const PdfList({super.key, required this.userId});
  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://rakthaseva.onrender.com/Certificate/${userId}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificates'),
      ),
      body: FutureBuilder(
        future: _fetchUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch user data'));
          } else {
            Map<String, dynamic> userData = snapshot.data;
            return ListView.builder(
              itemCount: userData['user_data'].length,
              itemBuilder: (BuildContext context, int index) {
                String certificateName =
                    userData['user_data'].values.toList()[index]['name'];
                String certificateUrl =
                    userData['user_data'].values.toList()[index]['url'];

                return ListTile(
                  title: Text(certificateName),
                  onTap: () async {
                    await FlutterDownloader.enqueue(
                      url: certificateUrl,
                      savedDir: '/path/to/download/directory/',
                      showNotification: true,
                      openFileFromNotification: true,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
