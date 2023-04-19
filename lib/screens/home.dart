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
      'https://user-images.githubusercontent.com/97867059/233001055-40730431-37b3-49b0-9cd6-a8d78eb602d0.jpeg',
      'https://user-images.githubusercontent.com/97867059/233001083-76e1d768-0791-47f4-ad7e-83889b4f0029.jpeg',
      'https://user-images.githubusercontent.com/97867059/233001086-4d6add70-38d9-43f6-9267-6e30ffcce0f2.jpeg',
      'https://user-images.githubusercontent.com/97867059/233001092-e59af73a-22ff-405e-8947-2063004653ba.jpeg',
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
                              DonationForm(user: widget.userData.userid),
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
