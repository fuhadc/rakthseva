import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controller/pdf.dart';

class PdfList extends StatefulWidget {
  final String userId;

  PdfList({required this.userId});

  @override
  _PdfListState createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  List<Pdf> _pdfList = [];

  Future<List<Pdf>> _fetchPdfList() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.11:5555/pdfs?userId=${widget.userId}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Pdf.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch PDF list');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPdfList().then((pdfList) {
      setState(() {
        _pdfList = pdfList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF List'),
      ),
      body: _pdfList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _pdfList.length,
              itemBuilder: (context, index) {
                final pdf = _pdfList[index];
                return ListTile(
                  title: Text(pdf.name),
                  trailing: IconButton(
                    icon: Icon(Icons.download),
                    onPressed: () {
                      downloadFile(pdf.url, pdf.name);
                    },
                  ),
                );
              },
            ),
    );
  }
}

Future<void> downloadFile(String url, String filename) async {
  HttpClient httpClient = HttpClient();
  File file = File(filename);

  try {
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    await response.pipe(file.openWrite());
  } catch (error) {
    print(error);
  } finally {
    httpClient.close();
  }
}
