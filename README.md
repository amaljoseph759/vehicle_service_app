# vehicle_service_app

A new Flutter project.

## Getting Started

#  Vehicle Service Booking App

A Flutter app to manage vehicle service bookings with offline SQLite support.

##  Features
- Onboarding screen
- User registration (local)
- Add & list vehicles
- Book services
- View service history
- Local storage using SQLite
- GetX for state management

##  Tech Stack
- Flutter
- GetX
- SQLite (sqflite)
- GetStorage

## ▶️ Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/amaljoseph759/vehicle_service_app.git
cd your-repo


lib/
├── core/
│   └── database_helper.dart      # Singleton SQLite manager
├── presentation/
│   ├── controllers/
│   │   └── vehicle_controller.dart
│   └── screens/
│       ├── add_vehicle_screen.dart
│       ├── auth_screen.dart
│       ├── book_service_screen.dart
│       ├── home_screen.dart
│       ├── onboarding_screen.dart
│       ├── service_history_screen.dart
│       └── vehicle_list_screen.dart
└── main.dart



 Install dependencies

 ---> flutter pub get


Run the app

-->flutter run


Build debug APK (for testing)

--> flutter build apk --debug
Output: build/app/outputs/flutter-apk/app-debug.apk



Local Database Details
DB File: services.db

Created using sqflite inside core/database_helper.dart

Tables:

vehicles: stores vehicle info

services: stores bookings

Auto-created on first app launch:
CREATE TABLE vehicles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  plate TEXT,
  vin TEXT,
  brand TEXT,
  model TEXT,
  year TEXT
);
