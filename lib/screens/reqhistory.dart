import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestHistoryPage extends StatefulWidget {
  final dynamic user;
  const RequestHistoryPage({
    super.key,
    required this.user,
  });
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
    final response = await http
        .get(Uri.parse('http://192.168.1.11:5555/bloodReq/${widget.user}'));
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
              itemBuilder: (BuildContext context, int index) {
                final request = _requests[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Date and Time: ${request['dateTime']}'),
                        SizedBox(height: 8),
                        Text('Blood Group: ${request['bloodGroup']}'),
                        SizedBox(height: 8),
                        Text('Address: ${request['address']}'),
                        SizedBox(height: 8),
                        Text('Phone: ${request['phone']}'),
                        SizedBox(height: 8),
                        Text('Unit: ${request['unit']}'),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
