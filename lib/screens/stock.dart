import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BloodStockPage extends StatefulWidget {
  @override
  _BloodStockPageState createState() => _BloodStockPageState();
}

class _BloodStockPageState extends State<BloodStockPage> {
  List<Map<String, dynamic>> _bloodStockData = [];

  @override
  void initState() {
    super.initState();
    _fetchBloodStockData();
  }

  Future<void> _fetchBloodStockData() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/bloodstock'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _bloodStockData =
            List<Map<String, dynamic>>.from(data['bloodStockData']);
      });
    } else {
      throw Exception('Failed to load blood stock data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Availability'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Blood Group')),
            DataColumn(label: Text('Whole Blood')),
            DataColumn(label: Text('Packed Cells')),
            DataColumn(label: Text('Frozen Plasma')),
            DataColumn(label: Text('Platelet')),
            DataColumn(label: Text('Last Updated')),
            DataColumn(label: Text('Location')),
            DataColumn(label: Text('Contact')),
          ],
          rows: List<DataRow>.generate(
            _bloodStockData.length,
            (index) {
              return DataRow(
                cells: [
                  DataCell(Text(_bloodStockData[index]['bloodGroup'])),
                  DataCell(
                      Text(_bloodStockData[index]['wholeBlood'].toString())),
                  DataCell(
                      Text(_bloodStockData[index]['packedCells'].toString())),
                  DataCell(
                      Text(_bloodStockData[index]['frozenPlasma'].toString())),
                  DataCell(Text(_bloodStockData[index]['platelet'].toString())),
                  DataCell(Text(_bloodStockData[index]['lastUpdated'])),
                  DataCell(Text(_bloodStockData[index]['location'])),
                  DataCell(Text(_bloodStockData[index]['contact'])),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
