import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location & Contact'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(12.994180, 77.590610),
                zoom: 16,
              ),
              markers: {
                const Marker(
                  markerId: MarkerId('Jain Hospital'),
                  position: LatLng(12.994180, 77.590610),
                  infoWindow: InfoWindow(
                    title: 'Bhagwan Mahaveer Jain Hospital',
                    snippet:
                        'Jain Hospital Millers Road, Vasanth Nagar, Bangalore, Karnataka 560052',
                  ),
                ),
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Located in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Bhagwan Mahaveer Jain Hospital',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Jain Hospital Millers Road, Vasanth Nagar, Bangalore, Karnataka 560052',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Hours',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Open 24 hours',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'For any queries, please contact us or write us at:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text('Contact: 89476324'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email),
                    SizedBox(width: 8),
                    Text('Mail: lions@gmail.com'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
