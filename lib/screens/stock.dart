import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BloodStockPage extends StatefulWidget {
  const BloodStockPage({Key? key}) : super(key: key);
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
        await http.get(Uri.parse('http://192.168.1.11:5555/bloodstock'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['bloodStockData'];
      setState(() {
        _bloodStockData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load blood stock data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Availability'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 444,
          width: 444,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Blood Group')),
                DataColumn(label: Text('Whole Blood')),
                DataColumn(label: Text('Packed Cells')),
                DataColumn(label: Text('Frozen Plasma')),
                DataColumn(label: Text('Platelet')),
              ],
              rows: List<DataRow>.generate(
                _bloodStockData.length,
                (index) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                          _bloodStockData[index]['bloodGroup'].toString())),
                      DataCell(Text(
                          _bloodStockData[index]['wholeBlood'].toString())),
                      DataCell(Text(
                          _bloodStockData[index]['packedCells'].toString())),
                      DataCell(Text(
                          _bloodStockData[index]['frozenPlasma'].toString())),
                      DataCell(
                          Text(_bloodStockData[index]['platelet'].toString())),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
