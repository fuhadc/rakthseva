import 'package:flutter/material.dart';

class SubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80.0,
              color: Colors.green,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Submission successful!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Thank you for submitting your form.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
