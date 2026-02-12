import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/scholarship.dart';

class ApiService {
  // Your provided Worker URL
  final String baseUrl = "https://scholara-api.vishwajeetadkine705.workers.dev";

  Future<List<Scholarship>> fetchScholarships({
    required String gpa,
    required String sat,
    required String toefl,
    required String educationLevel,
    required String fieldOfStudy,
    required List<String> targetCountries,
  }) async {
    try {
      // 1. Construct the body exactly as your Worker expects it
      final Map<String, dynamic> body = {
        "gpa": gpa,
        "sat": sat,
        "toefl": toefl, // Using toefl key for both IELTS/TOEFL for simplicity
        "originCountry": "India", // Hardcoded based on profile, or can be dynamic
        "fieldOfStudy": fieldOfStudy.isEmpty ? "Computer Science" : fieldOfStudy,
        "studyLevel": educationLevel.isEmpty ? "Bachelor" : educationLevel,
        "targetRegion": targetCountries.isNotEmpty ? targetCountries.join(", ") : "USA, UK, Europe",
      };

      // 2. Send POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // 3. Parse the 'scholarships' array from the response
        if (data['scholarships'] != null) {
          final List<dynamic> list = data['scholarships'];
          return list.map((json) => Scholarship.fromJson(json)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load scholarships: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
}
