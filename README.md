# Scholira - AI-Powered Scholarship Discovery Platform

<div align="center">

![Scholira Logo](https://img.shields.io/badge/Scholira-Scholarship_Discovery-4C4DDC?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart)

**Discover Global Scholarships Tailored to Your Profile**

[Features](#features) • [Installation](#installation) • [Architecture](#architecture) • [API](#api-integration) • [Contributing](#contributing)

</div>

---

## 📖 Overview

**Scholira** is a cross-platform mobile application built with Flutter that helps students discover scholarship opportunities worldwide. Using AI-powered matching algorithms, the app analyzes user profiles (GPA, test scores, field of study, target countries) and recommends the most relevant scholarships from a curated database.

### 🎯 Key Highlights

- **Personalized Recommendations**: AI-driven matching based on academic profile
- **Global Coverage**: Scholarships from USA, UK, Germany, South Korea, Turkey, China, Japan, and more
- **Beautiful UI**: Modern, intuitive design with smooth animations
- **Multi-step Onboarding**: Comprehensive profile creation flow
- **Real-time Data**: Integration with scholarship API for up-to-date opportunities
- **Cross-platform**: Runs on iOS, Android, Web, Windows, macOS, and Linux

---

## ✨ Features

### 🔐 User Onboarding
- **4-Step Profile Creation**:
  1. Personal Information (Name, Email, Age)
  2. Education Level & Field of Study selection
  3. Goal Selection (Full Grant, Internship, Language Learning, Networking)
  4. Target Country Selection (Multi-select)
- Language switcher (EN by default)
- Skip option for quick access
- Progress indicators

### 🏠 Home Screen
- Curated scholarship feed with verified badges
- Search functionality with filter options
- Card-based layout with key scholarship details
- Pull-to-refresh capability
- Bottom navigation (Home, Saved, Profile)

### 📄 Scholarship Details
- Comprehensive information display:
  - Program description
  - Location and degree type
  - Funding amount
  - Application requirements
  - Eligibility criteria
- Dark-themed header with key stats
- Direct "Apply Verified" button
- Bookmark functionality

### 👤 Profile Screen
- User profile with verification badge
- Activity tracking (Saved, Applied)
- Recent activity timeline
- Student tier system

---

## 🚀 Installation

### Prerequisites

- **Flutter SDK**: 3.0 or higher
- **Dart SDK**: 3.0 or higher
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Platform-specific tools**:
  - iOS: Xcode 14+ (macOS only)
  - Android: Android Studio with SDK 21+
  - Web: Chrome browser
  - Desktop: Platform-specific build tools

### Setup Steps

1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/scholira.git
cd scholira
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Verify Installation**
```bash
flutter doctor
```

4. **Run the App**
```bash
# For mobile/desktop
flutter run

# For web
flutter run -d chrome

# For specific platform
flutter run -d <device_id>
```

5. **Build for Production**
```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

---

## 🏗️ Architecture

### Project Structure

```
scholira/
├── lib/
│   ├── constants/
│   │   └── app_colors.dart          # Color palette constants
│   ├── models/
│   │   └── scholarship.dart         # Scholarship data model
│   ├── screens/
│   │   ├── onboarding_screen.dart   # 4-step user onboarding
│   │   ├── home_screen.dart         # Main feed & navigation
│   │   ├── details_screen.dart      # Scholarship details
│   │   └── profile_screen.dart      # User profile
│   ├── services/
│   │   └── api_service.dart         # API integration & mock data
│   ├── widgets/
│   │   └── scholarship_card.dart    # Reusable scholarship card
│   └── main.dart                    # App entry point
├── android/                         # Android-specific files
├── ios/                            # iOS-specific files
├── web/                            # Web-specific files
├── windows/                        # Windows-specific files
├── linux/                          # Linux-specific files
├── macos/                          # macOS-specific files
└── pubspec.yaml                    # Dependencies & assets
```

### Design Patterns

- **BLoC Pattern**: State management (can be integrated)
- **Repository Pattern**: Data layer abstraction in `api_service.dart`
- **Widget Composition**: Modular, reusable UI components
- **Singleton**: API service instance management

### Color Scheme

```dart
Primary:     #4C4DDC (Blue-Purple)
Secondary:   #1E1E2C (Dark Text)
Background:  #F8F9FD (Light Blue-Grey)
Surface:     #FFFFFF (White)
Success:     #27AE60 (Green)
Text Grey:   #A1A4B2 (Medium Grey)
Input Fill:  #F2F3F7 (Light Grey)
```

---

## 🔌 API Integration

### Base Endpoint
```
https://scholara-api.vishwajeetadkine705.workers.dev
```

### Request Format
```json
POST /
{
  "gpa": "3.8",
  "sat": "1450",
  "toefl": "105",
  "originCountry": "Uzbekistan",
  "fieldOfStudy": "Computer Science",
  "studyLevel": "Bachelor",
  "targetRegion": "USA, UK, Europe"
}
```

### Response Format
```json
{
  "scholarships": [
    {
      "name": "Chevening UK 2025",
      "provider": "UK Government",
      "amount": "Full Fund",
      "deadline": "Nov 2025",
      "description": "The Chevening Scholarship...",
      "location": "London, United Kingdom",
      "eligibility": ["IELTS 6.5+", "Bachelor Degree", "2 Years Exp"]
    }
  ]
}
```

### Fallback Strategy

The app includes mock data for offline functionality and API failure scenarios:
- **Chevening UK 2025**: UK Government, Full Fund
- **DAAD Scholarship**: German Government, Full Fund
- **Fulbright Program**: USA Government, Full Fund

---

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0      # Poppins font family
  http: ^1.2.0              # HTTP client for API calls
  intl: ^0.19.0             # Internationalization support
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0     # Lint rules
```

---

## 🎨 UI/UX Design

### Typography
- **Font Family**: Poppins (via Google Fonts)
- **Header**: Bold, 26-32px
- **Body**: Regular, 14-16px
- **Labels**: Bold, 10-12px, uppercase, letter-spacing

### Components

#### Scholarship Card
- White background with subtle shadow
- Icon + Title + Location
- Verified badge with success color
- Funding amount badge
- Tap to navigate to details

#### Onboarding Steps
- Circular step indicators
- Check marks for completed steps
- Blue primary color for active step
- Continue button with arrow
- Back/Skip options

#### Detail Screen
- Dark header with floating back button
- Stats badges (Location, Degree, Funding)
- White content area with rounded top
- Requirements checklist
- Apply button with external link icon

---

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure
```
test/
├── widget_test.dart         # Widget tests (needs update)
├── models/
│   └── scholarship_test.dart
├── services/
│   └── api_service_test.dart
└── screens/
    └── home_screen_test.dart
```

---

## 🌐 Localization

Currently supports **English (EN)**. To add more languages:

1. Install `flutter_localizations`:
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
```

2. Create `l10n/` directory with ARB files:
```
l10n/
├── app_en.arb
├── app_es.arb
└── app_de.arb
```

3. Update `MaterialApp`:
```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
)
```

---

## 🛠️ Configuration

### Android
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: Latest
- **Package**: `com.example.scholira`

### iOS
- **Min iOS Version**: 13.0
- **Bundle ID**: `com.example.scholira`

### Web
- **Base href**: Configured in `web/index.html`
- **Icons**: PWA icons in `web/icons/`

---

## 🚧 Roadmap

### Phase 1 (Current)
- [x] Basic UI implementation
- [x] API integration
- [x] Mock data fallback
- [x] Profile creation flow

### Phase 2 (Planned)
- [ ] User authentication (Firebase/Supabase)
- [ ] Bookmark/Save functionality
- [ ] Application tracking
- [ ] Push notifications for deadlines
- [ ] Advanced filtering

### Phase 3 (Future)
- [ ] AI-powered essay assistance
- [ ] Document upload & management
- [ ] Application progress tracking
- [ ] Social features (reviews, ratings)
- [ ] Multi-language support

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the Repository**
2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit Your Changes**
   ```bash
   git commit -m 'Add amazing feature'
   ```
4. **Push to Branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` before committing
- Write tests for new features
- Update documentation

---

## 🙏 Acknowledgments

- **UI Design**: Inspired by modern scholarship platforms
- **Icons**: Material Design Icons
- **Fonts**: Google Fonts (Poppins)
- **API**: Cloudflare Workers backend

---


**Made with ❤️ for students worldwide**

[⬆ Back to Top](#scholira---ai-powered-scholarship-discovery-platform)

</div>
