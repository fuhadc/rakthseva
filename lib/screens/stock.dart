import 'package:flutter/material.dart';

import '../services/bloodapi.dart';

class BloodStockPage extends StatefulWidget {
  @override
  _BloodStockPageState createState() => _BloodStockPageState();
}

class _BloodStockPageState extends State<BloodStockPage> {
  Map<String, dynamic> _bloodStock = {};

  @override
  void initState() {
    super.initState();
    _fetchBloodStock();
  }

  Future<void> _fetchBloodStock() async {
    try {
      final bloodStock = await BloodApi.getBloodStock();
      setState(() {
        _bloodStock = bloodStock;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Stock'),
      ),
      body: _bloodStock.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                _buildTableHeader(),
                _buildTableRow('O+', _bloodStock['-NTR-wNIbeb26-sfWRkl']),
                // Add more rows for other blood groups
              ],
            ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Blood Group'),
            Text('Whole Blood'),
            Text('Packed Cells'),
            Text('Frozen Plasma'),
            Text('Platelets'),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String bloodGroup, Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(bloodGroup),
          Text(data['whole_blood']),
          Text(data['packed_cells']),
          Text(data['frozen_plasma']),
          Text(data['platelets']),
        ],
      ),
    );
  }
}
