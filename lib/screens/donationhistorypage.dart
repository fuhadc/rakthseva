import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/donationhistory.dart';
import 'package:http/http.dart' as http;

class DonationHistoryPage extends StatefulWidget {
  final String userId;

  const DonationHistoryPage({required this.userId});

  @override
  _DonationHistoryPageState createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
  late List<DonationHistory> _donationHistoryList;

  @override
  void initState() {
    super.initState();
    _loadDonationHistory();
  }

  Future<void> _loadDonationHistory() async {
    final response = await http.get(Uri.parse('API endpoint URL'));
    final data = json.decode(response.body);

    setState(() {
      _donationHistoryList = List<DonationHistory>.from(
          data.map((item) => DonationHistory.fromJson(item)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation History'),
      ),
      body: ListView.builder(
        itemCount: _donationHistoryList.length,
        itemBuilder: (context, index) {
          final donationHistory = _donationHistoryList[index];
          return ListTile(
            title: Text(donationHistory.name),
            subtitle: Text(donationHistory.lastDonationDate),
            trailing: Text(donationHistory.medicalHistory),
          );
        },
      ),
    );
  }
}
