# Mini Zomato - Food Delivery App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Firebase](https://img.shields.io/badge/Firebase-10.x-orange)
![License](https://img.shields.io/badge/License-MIT-green)

Mini Zomato is a Flutter-based food delivery application that allows users to browse restaurants, view menus, add items to cart, place orders, and manage their delivery addresses. The app is built with clean architecture principles, providing a scalable, maintainable, and testable codebase.

## 📱 Features

- **User Authentication**: Sign up, login, and logout functionality
- **Restaurant Browsing**: View list of restaurants
- **Menu Exploration**: Browse restaurant menus with detailed item information
- **Cart Management**: Add items to cart, grouped by restaurant
- **Order Placement**: Place orders with selected items
- **Order History**: View past orders and their statuses
- **Address Management**: Add, view, and delete delivery addresses


## Architecture / BLoC Flow Diagram

![diagram-export-6-11-2025-12_04_33-PM](https://github.com/user-attachments/assets/2e7f4df2-63e4-4998-b4a1-0481412aa3d9)

## 🏗️ Architecture

The application follows Clean Architecture principles with a clear separation of concerns:

### Layers

1. **Presentation Layer**
   - **Screens**: UI components for different app screens
   - **Widgets**: Reusable UI components
   - **BLoC**: State management for different features

2. **Domain Layer**
   - **Entities**: Core business objects
   - **Use Cases**: Application-specific business rules
   - **Repositories**: Abstract interfaces for data operations

3. **Data Layer**
   - **Data Sources**: Implementations for external services (Firebase, APIs)
   - **Models**: Data classes for mapping to/from external data
   - **Repository Implementations**: Concrete implementations of domain repositories

### Key Architectural Decisions

- **BLoC Pattern**: Used for state management, providing a clear separation between UI and business logic
- **Dependency Injection**: Implemented using `get_it` for easier testing and dependency management
- **Repository Pattern**: Abstracts data sources for flexible data access
- **Error Handling**: Uses Either type from `dartz` for functional error handling

## 🛠️ Technologies & Libraries

### State Management
- **flutter_bloc**: BLoC pattern implementation
- **bloc**: Core BLoC package

### Dependency Injection
- **get_it**: Service locator for dependency injection


### Firebase
- **firebase_core**: Firebase app initialization
- **firebase_auth**: Authentication services
- **cloud_firestore**: NoSQL database for data storage

### Code Generation & Serialization
- **freezed**: Data class generation
- **json_annotation**: JSON serialization/deserialization annotations
- **json_serializable**: JSON serialization/deserialization code generation

### Utilities
- **dartz**: Functional programming constructs
- **uuid**: Unique identifier generation
- **google_fonts**: Access to Google's font library

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK (3.x or higher)
- Firebase account
- Android Studio / VS Code

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/mini_zomato_user.git
   cd mini_zomato_user
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project in the Firebase Console
   - Enable Authentication (Email/Password)
   - Set up Cloud Firestore database
   - Download `google-services.json` (for Android) and place in `android/app/`
   - Download `GoogleService-Info.plist` (for iOS) and place in `ios/Runner/`

4. **Generate required files**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## 📚 Project Structure

```
lib/
  ├── data/                  # Data layer
  │   ├── datasource/        # External data source implementations
  │   ├── models/            # Data models for API/Firebase
  │   └── repository/        # Repository implementations
  │
  ├── domain/                # Business logic layer
  │   ├── entities/          # Business objects
  │   ├── repository/        # Repository interfaces
  │   └── usecases/          # Application-specific business rules
  │
  ├── presentation/          # UI layer
  │   ├── bloc/              # BLoC state management
  │   ├── cubit/             # Cubit state management
  │   ├── screens/           # Application screens
  │   └── widgets/           # Reusable UI components
  │
  ├── themes/                # Theme-related files
  │   ├── colors.dart
  │   ├── icons.dart
  │   └── themes.dart
  │
  ├── utils/                 # Utility classes and functions
  │   ├── dependencies.dart  # Dependency injection setup
  │   └── extensions/        # Dart/Flutter extensions
  │
  ├── firebase_options.dart  # Firebase configuration
  └── main.dart              # Application entry point
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
