class DonationHistory {
  final String name;
  final String phoneNumber;
  final String address;
  final String dateOfBirth;
  final String medicalHistory;
  final String lastDonationDate;
  final String gender;

  DonationHistory({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.medicalHistory,
    required this.lastDonationDate,
    required this.gender,
  });

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      name: json['name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      medicalHistory: json['medical_history'],
      lastDonationDate: json['last_donation_date'],
      gender: json['gender'],
    );
  }
}
