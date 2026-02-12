class Scholarship {
  final String title;       // Mapped from 'name'
  final String provider;    // Mapped from 'provider'
  final String amount;      // Mapped from 'amount'
  final String deadline;    // Mapped from 'deadline'
  final String description; // Mapped from 'description'
  final String location;    // Mapped from 'location'
  final List<String> eligibility; // Mapped from 'eligibility' array

  Scholarship({
    required this.title,
    required this.provider,
    required this.amount,
    required this.deadline,
    required this.description,
    required this.location,
    required this.eligibility,
  });

  factory Scholarship.fromJson(Map<String, dynamic> json) {
    return Scholarship(
      title: json['name'] ?? 'Unknown Scholarship',
      provider: json['provider'] ?? 'Unknown Provider',
      amount: json['amount'] ?? 'Not specified',
      deadline: json['deadline'] ?? 'Open',
      description: json['description'] ?? '',
      location: json['location'] ?? 'International',
      eligibility: json['eligibility'] != null 
          ? List<String>.from(json['eligibility']) 
          : [],
    );
  }
}
