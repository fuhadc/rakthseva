import 'package:flutter/material.dart';

class SubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80.0,
              color: Colors.green,
            ),
            SizedBox(height: 16.0),
            Text(
              'Submission successful!',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Thank you for submitting your form.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Form'),
            ),
          ],
        ),
      ),
    );
  }
}
