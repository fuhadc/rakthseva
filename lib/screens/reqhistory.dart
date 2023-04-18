import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestHistoryPage extends StatefulWidget {
  @override
  _RequestHistoryPageState createState() => _RequestHistoryPageState();
}

class _RequestHistoryPageState extends State<RequestHistoryPage> {
  List<dynamic> _requests = [];

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  void _fetchRequests() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/requests'));
    if (response.statusCode == 200) {
      setState(() {
        _requests = json.decode(response.body);
      });
    } else {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request History'),
      ),
      body: _requests.isNotEmpty
          ? ListView.builder(
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return ListTile(
                  title: Text(request['name']),
                  subtitle: Text(request['bloodGroup']),
                  trailing: Text(request['unit']),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
