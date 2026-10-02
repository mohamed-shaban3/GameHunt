# 🎮 GameHunt

A feature-rich Flutter application for gaming enthusiasts to discover video games, compare live prices across multiple digital stores, and manage their personal game backlog offline.

---

## ✨ Key Features

* 🚀 **Game Discovery & Trending**: Explore top-rated and newly released games powered by the **RAWG API**.
* 💰 **Multi-Store Price Comparison**: Compare live game deals and prices across major platforms (Steam, Epic Games, GOG) integrated via **CheapShark API**.
* 🔗 **Direct Store Redirection**: Launch deal links directly into the browser or store app using `url_launcher`.
* 📚 **Offline Game Backlog Manager**: Save games locally and organize them into custom lists (*Playing*, *Completed*, *Wishlist*) backed by **Sqflite**.
* 🔍 **Smart Debounced Search & Filtering**: Search games with real-time API debouncing and filter by genres (Action, RPG, Sports, etc.).
* 🔄 **Infinite Scroll Pagination**: Smooth data fetching on scroll for large game catalogs.
* 💀 **Shimmer Loading Effects**: Smooth skeleton screens during image and data fetching for a polished UI/UX.

---

## 🛠️ Tech Stack & Architecture

* **Framework**: [Flutter](https://flutter.dev) (Dart)
* **Architecture**: Clean Architecture / Feature-First
* **State Management**: BLoC / Cubit (`flutter_bloc`)
* **Networking**: `Dio` (REST API client with Interceptors)
* **Local Storage**: `Sqflite` (SQLite database)
* **UI & UX**: `shimmer`, `cached_network_image`
* **External Utilities**: `url_launcher`

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
├── core/            # Network clients (Dio), Local Database (Sqflite), Themes, Utilities
└── features/
    ├── games/       # Home, Search, RAWG API logic
    ├── deals/       # Price comparison, CheapShark API logic
    └── backlog/     # Offline local database logic & Wishlist screens
👨‍💻 Author
Mohamed Shaban

GitHub: @mohamed-shaban3

LinkedIn: https://linkedin.com/in/mohamed-shaban0
