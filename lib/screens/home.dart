import 'package:flutter/material.dart';
import 'package:rakthseva/screens/Location.dart';
import 'package:rakthseva/screens/NotificationPage.dart';
import 'package:rakthseva/screens/profile.dart';
import 'package:rakthseva/screens/stock.dart';

import '../controller/user.dart';
import 'blood_req.dart';
import 'facts.dart';
import 'form.dart';

class HomePage extends StatefulWidget {
  final User userData;

  const HomePage({Key? key, required this.userData}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages().then((images) {
      setState(() {
        _images = images;
      });
    });
  }

  Future<List<String>> _fetchImages() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return [
      'https://via.placeholder.com/500x250',
      'https://via.placeholder.com/500x251',
      'https://via.placeholder.com/500x252',
      'https://via.placeholder.com/500x253',
      'https://via.placeholder.com/500x254',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationPage(userId: widget.userData.userid),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              debugPrint(widget.userData.getUserDetails());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: widget.userData),
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.navigation),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationPage(),
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 500,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(_images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Donate Blood',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DonationForm(user: widget.userData),
                        ));
                  },
                  child: Text('Donate Blood'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BloodStockPage(),
                        ));
                  },
                  child: const Text('View Stock'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Request Blood',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyForm(userId: widget.userData.userid),
                        ));
                    // TODO: Implement request blood functionality.
                  },
                  child: Text('Request Blood'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BloodDonationFactsPage()));

                    // TODO: Implement facts about donation functionality.
                  },
                  child: const Text('Facts about Donation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
