import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  final String userId;

  const NotificationPage({required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notification> _notifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'http://192.168.1.11:5555/api/notifications?userId=${widget.userId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> notificationsJson = data['notifications'];
      final notifications =
          notificationsJson.map((json) => Notification.fromJson(json)).toList();
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _notifications.isEmpty
              ? const Center(
                  child: Text('No notifications'),
                )
              : ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notification = _notifications[index];
                    return ListTile(
                      leading: const Icon(Icons.notification_important),
                      title: Text(notification.title),
                      subtitle: Text(notification.body),
                      trailing: Text(notification.date),
                    );
                  },
                ),
    );
  }
}

class Notification {
  final String title;
  final String body;
  final String date;

  Notification({
    required this.title,
    required this.body,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }
}
