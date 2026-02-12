import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data to pass to API
  final TextEditingController _gpaController = TextEditingController();
  final TextEditingController _satController = TextEditingController();
  final TextEditingController _toeflController = TextEditingController(); // serves for IELTS too
  String _educationLevel = "Bachelor";
  String _selectedField = "IT & CS";
  final List<String> _selectedDestinations = [];

  void _finishSetup() {
    // Navigate to Home and pass the collected data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationWrapper(
          gpa: _gpaController.text,
          sat: _satController.text,
          toefl: _toeflController.text,
          educationLevel: _educationLevel,
          fieldOfStudy: _selectedField,
          targetCountries: _selectedDestinations,
        ),
      ),
    );
  }

  void _skip() {
    // Navigate with defaults/empty data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationWrapper(
          gpa: "", sat: "", toefl: "", 
          educationLevel: "Bachelor", 
          fieldOfStudy: "Computer Science", 
          targetCountries: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Step Indicators
                  Row(
                    children: List.generate(3, (index) => _buildDot(index)),
                  ),
                  TextButton(onPressed: _skip, child: const Text("Skip", style: TextStyle(color: AppColors.textGrey))),
                ],
              ),
            ),
            
            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (p) => setState(() => _currentPage = p),
                children: [
                  _buildEducationStep(),
                  _buildGoalsStep(), // Visual only
                  _buildDestinationsStep(),
                ],
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300), 
                        curve: Curves.easeInOut
                      );
                    } else {
                      _finishSetup();
                    }
                  },
                  child: Text(_currentPage == 2 ? "Find Scholarships" : "Continue"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    bool active = index == _currentPage;
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // --- Step 1: Education & Scores ---
  Widget _buildEducationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Academic Profile", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _label("EDUCATION LEVEL"),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: ["High School", "Bachelor", "Master", "PhD"].map((e) => 
              _chip(e, _educationLevel == e, () => setState(() => _educationLevel = e))
            ).toList(),
          ),
          const SizedBox(height: 20),
          _label("SCORES (Optional)"),
          Row(
            children: [
              Expanded(child: _input(_gpaController, "GPA (e.g 3.8)")),
              const SizedBox(width: 10),
              Expanded(child: _input(_satController, "SAT Score")),
            ],
          ),
          const SizedBox(height: 10),
          _input(_toeflController, "IELTS / TOEFL Score"),
          
          const SizedBox(height: 20),
          _label("FIELD OF STUDY"),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: ["IT & CS", "Business", "Engineering", "Medical", "Arts"].map((e) => 
              _chip(e, _selectedField == e, () => setState(() => _selectedField = e))
            ).toList(),
          ),
        ],
      ),
    );
  }

  // --- Step 2: Goals (Visual) ---
  Widget _buildGoalsStep() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What is your goal?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("This helps us filter the best opportunities.", style: TextStyle(color: Colors.grey)),
          Spacer(), 
          Center(child: Icon(Icons.flag_rounded, size: 100, color: Color(0xFFEEEEEE))),
          Spacer(),
        ],
      ),
    );
  }

  // --- Step 3: Destinations ---
  Widget _buildDestinationsStep() {
    final countries = ["USA", "UK", "Canada", "Germany", "Australia", "Japan"];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Target Countries", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.8, crossAxisSpacing: 10, mainAxisSpacing: 10
              ),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final c = countries[index];
                final selected = _selectedDestinations.contains(c);
                return InkWell(
                  onTap: () => setState(() {
                    selected ? _selectedDestinations.remove(c) : _selectedDestinations.add(c);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    alignment: Alignment.center,
                    child: Text(c, style: TextStyle(
                      color: selected ? Colors.white : Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)));
  
  Widget _input(TextEditingController c, String hint) => TextField(
    controller: c, 
    decoration: InputDecoration(
      hintText: hint, 
      filled: true, 
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
    )
  );

  Widget _chip(String label, bool selected, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black)),
    ),
  );
}
