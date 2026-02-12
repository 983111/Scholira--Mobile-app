import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/scholarship.dart';
import '../services/api_service.dart';
import '../widgets/scholarship_card.dart';
import 'profile_screen.dart';

// Wrapper to handle Bottom Navigation
class MainNavigationWrapper extends StatefulWidget {
  final String gpa;
  final String sat;
  final String toefl;
  final String educationLevel;
  final String fieldOfStudy;
  final List<String> targetCountries;

  const MainNavigationWrapper({
    super.key,
    required this.gpa,
    required this.sat,
    required this.toefl,
    required this.educationLevel,
    required this.fieldOfStudy,
    required this.targetCountries,
  });

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        gpa: widget.gpa,
        sat: widget.sat,
        toefl: widget.toefl,
        educationLevel: widget.educationLevel,
        fieldOfStudy: widget.fieldOfStudy,
        targetCountries: widget.targetCountries,
      ),
      const Center(child: Text("Saved (Coming Soon)")),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: AppColors.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String gpa;
  final String sat;
  final String toefl;
  final String educationLevel;
  final String fieldOfStudy;
  final List<String> targetCountries;

  const HomeScreen({
    super.key,
    required this.gpa,
    required this.sat,
    required this.toefl,
    required this.educationLevel,
    required this.fieldOfStudy,
    required this.targetCountries,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Scholarship>> _futureScholarships;

  @override
  void initState() {
    super.initState();
    // CALL THE API HERE
    _futureScholarships = ApiService().fetchScholarships(
      gpa: widget.gpa,
      sat: widget.sat,
      toefl: widget.toefl,
      educationLevel: widget.educationLevel,
      fieldOfStudy: widget.fieldOfStudy,
      targetCountries: widget.targetCountries,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              const Row(
                children: [
                  CircleAvatar(backgroundColor: AppColors.primary, child: Text("S", style: TextStyle(color: Colors.white))),
                  SizedBox(width: 10),
                  Text("Scholira AI", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text("Matches for you", style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Results List
              Expanded(
                child: FutureBuilder<List<Scholarship>>(
                  future: _futureScholarships,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error loading data.\n${snapshot.error}", textAlign: TextAlign.center));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No scholarships found matching your profile."));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ScholarshipCard(scholarship: snapshot.data![index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
