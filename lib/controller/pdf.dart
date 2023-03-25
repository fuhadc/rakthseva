class Pdf {
  final String name;
  final String url;

  Pdf({required this.name, required this.url});

  factory Pdf.fromJson(Map<String, dynamic> json) {
    return Pdf(
      name: json['name'],
      url: json['url'],
    );
  }
}
