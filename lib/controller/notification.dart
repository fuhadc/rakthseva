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

  Map<String, dynamic> toJson() {
    return {'tittle': title, 'body': body, 'date': date};
  }
}
