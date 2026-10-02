# 🎮 GameHunt

A feature-rich Flutter application for gaming enthusiasts to discover video games, compare live prices across multiple digital stores, and manage their personal game backlog offline.

---

## 📄 Project Documentation

* 📈 **[Business Requirements Document (BRD)](./docs/BRD.md)**
* 📋 **[Product Requirements Document (PRD)](./docs/PRD.md)**

---

## 🚀 Key Features

* 🎯 **Game Discovery & Trending**: Explore top-rated and newly released games powered by the **RAWG API**.
* 💰 **Multi-Store Price Comparison**: Compare live game deals and prices across major platforms (Steam, Epic Games, GOG) integrated via **CheapShark API**.
* 🔗 **Direct Store Redirection**: Launch deal links directly into the browser or store app using `url_launcher`.
* 📱 **Offline Game Backlog Manager**: Save games locally and organize them into custom lists (*Playing*, *Completed*, *Wishlist*) backed by **Sqflite**.
* 🔍 **Smart Debounced Search & Filtering**: Search games with real-time API debouncing and filter by genres.
* ♾️ **Infinite Scroll Pagination**: Smooth data fetching on scroll for large game catalogs.
* 💀 **Shimmer Loading Effects**: Smooth skeleton screens during image and data fetching.
* 🔔 **Push Notifications & Deep Linking**: Firebase Cloud Messaging (FCM) for live updates and direct screen navigation.

---

## 🛠 Tech Stack & Architecture

* **Framework**: [Flutter](https://flutter.dev) (Dart)
* **Architecture**: Clean Architecture / Feature-First
* **State Management**: BLoC / Cubit (`flutter_bloc`)
* **Networking**: `Dio` (REST API client with Interceptors)
* **Local Storage**: `Sqflite` (SQLite database) & `CacheHelper`
* **UI & UX**: `shimmer`, `cached_network_image`
* **External Utilities**: `url_launcher`, `firebase_messaging`

---

## 🔌 API Integrations

* **[RAWG Video Games Database API](https://rawg.io/apidocs)**: Game metadata, screenshots, descriptions, and release dates.
* **[CheapShark API](https://apidocs.cheapshark.com/)**: Live game deals, discounts, and store pricing comparisons.

---

## 💻 Getting Started

### Prerequisites

* Flutter SDK (Latest Stable Version)
* Android Studio / VS Code
* RAWG API Key

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/mohamed-shaban3/GameHunt.git](https://github.com/mohamed-shaban3/GameHunt.git)
Navigate to the project directory:

Bash
cd GameHunt
Install dependencies:

Bash
flutter pub get
Run the app:

Bash
flutter run
📁 Project Structure
Plaintext
lib/
├── core/
│   ├── local/          # Local caching (CacheHelper)
│   ├── networking/     # Dio factory, API Services & Error Handling
│   ├── routes/         # App routing & navigation setup
│   ├── theme/          # App themes and typography
│   ├── utils/          # Constants, helpers, and extensions
│   └── widgets/        # Shared custom UI widgets
│
├── features/
│   ├── auth/           # Authentication & User Onboarding
│   ├── favorites/      # Saved favorite games management
│   ├── games/          # Game catalog, search, details & repositories
│   ├── main_layout/    # Root navigation layout
│   ├── notifications/  # FCM notifications & logic
│   └── profile/        # User profile & settings
│
├── game_hunt.dart      # MaterialApp configuration
└── main.dart           # App entry point

👤 Author
Mohamed Shaban

GitHub: @mohamed-shaban3

LinkedIn: mohamed-shaban0
