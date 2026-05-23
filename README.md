# 🎬 iFox - Movie App

<p align="center">
  <b>Free iFox</b> — A modern, feature-rich movie browsing application built with Flutter
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9.2-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.9.2-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Firebase-Auth%20%26%20Firestore-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
  <img src="https://img.shields.io/badge/TMDB-API-01D277?style=for-the-badge&logo=themoviedatabase&logoColor=white" alt="TMDB">
  <img src="https://img.shields.io/badge/BLoC-State%20Management-blue?style=for-the-badge" alt="BLoC">
  <img src="https://img.shields.io/badge/Version-1.0.0-red?style=for-the-badge" alt="Version">
</p>

---

## 📖 About

**iFox** is a sleek and modern movie application where you can explore and stay updated with the latest movies. Browse trending films, view detailed information, watch trailers directly in-app, search for any movie, and add your favorites to a personalized list — all powered by real-time data from **TMDB (The Movie Database)** API.

> Designed & Developed by **Tarek Hayan**

---

## ✨ Features

### 🔐 Authentication
- **Sign Up** — Create a new account using email and password via Firebase Authentication
- **Sign In** — Log in with existing credentials
- **Auto Login** — Automatic authentication state detection (stays logged in)
- **Sign Out** — Secure logout from the profile screen
- **Error Handling** — Detailed error messages for invalid email, disabled accounts, wrong credentials, etc.

### 🏠 Home Screen
- **Now Playing Carousel** — Auto-sliding carousel showcasing currently playing movies
- **Genre List** — Horizontal scrollable list of movie genres with filtering
- **Popular Movies** — Browse popular movies with infinite scroll / pagination
- **Top Rated Movies** — Explore top-rated movies of all time

### 🔍 Search
- **Movie Search** — Search for any movie by title using the TMDB search API
- **Search Results** — View search results in a responsive grid/list layout
- **Quick Navigation** — Tap on any result to view movie details

### 🎬 Movie Details
- **Full Movie Info** — View movie poster, title, release date, language, rating, and overview
- **Star Rating** — Display movie rating with a styled badge
- **Watch Trailer** — Watch official YouTube trailers directly in the app
- **Add to Favorites** — Save movies to your personal favorites list stored in Firebase

### 🎥 Trailer Player
- **YouTube Integration** — Watch movie trailers using the embedded YouTube player
- **Auto Play** — Trailers start playing automatically
- **Fullscreen Support** — Watch trailers in fullscreen mode

### ❤️ Favorites
- **Save Favorites** — Add/remove movies from favorites with a single tap
- **Cloud Sync** — Favorites are stored in Firebase Firestore (synced across devices)
- **Real-time Updates** — Favorites list updates in real-time using Firestore streams
- **Detailed Cards** — View saved movies with poster, title, rating, and release date

### 👤 Profile
- **User Info** — Display user email and username (extracted from email)
- **Avatar** — Auto-generated avatar with the first letter of the user's email
- **App Info** — View app details and version information
- **Logout** — Securely sign out from the application

### 📱 Responsive Design
- **Mobile** — Optimized bottom navigation bar and stacked layouts
- **Tablet** — Adjusted spacing, fonts, and touch targets
- **Desktop/Web** — Navigation rail, side-by-side layouts, and grid views

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** `^3.9.2` | Cross-platform UI framework |
| **Dart** `^3.9.2` | Programming language |
| **BLoC / Cubit** `^9.1.1` | State management |
| **Firebase Auth** `^6.1.1` | User authentication |
| **Cloud Firestore** `^6.0.3` | Cloud database for favorites |
| **Firebase Core** `^4.2.0` | Firebase initialization |
| **Dio** `^5.9.0` | HTTP client for API calls |
| **TMDB API** | Movie data source |
| **YouTube Player iFrame** `^5.2.2` | Embedded YouTube trailer player |
| **Carousel Slider** `^5.1.1` | Image carousel for now playing movies |
| **Font Awesome Flutter** `^10.10.0` | Icon pack |
| **Package Info Plus** `^9.0.0` | App version information |

---

## 🏗️ Project Architecture

The project follows a **clean architecture** pattern with clear separation of concerns:

```
lib/
├── main.dart                          # App entry point & route configuration
├── firebase_options.dart              # Firebase configuration (auto-generated)
│
├── constants/                         # App-wide constants
│   ├── colors.dart                    # Primary color (brand red #D12F26)
│   └── texts.dart                     # API key, base URL, image URL
│
├── data/                              # Data layer
│   ├── models/                        # Data models
│   │   ├── movie_model.dart           # Movie data model (id, title, image, rating, etc.)
│   │   ├── genre_movies_model.dart    # Genre model
│   │   └── trilar_movie_model.dart    # Trailer model (YouTube key)
│   │
│   ├── web/                           # API services (remote data sources)
│   │   ├── movie_api.dart             # Fetch popular, top rated, now playing movies
│   │   ├── search_movie_api.dart      # Search movies by query
│   │   ├── categery_movie_api.dart    # Fetch movies by category
│   │   ├── genre_movies_api.dart      # Fetch movie genres list
│   │   └── trilar_movie_api.dart      # Fetch movie trailers from TMDB
│   │
│   └── repos/                         # Repositories (data abstraction layer)
│       ├── movie_repo.dart            # Movie repository
│       ├── search_movie_repo.dart     # Search repository
│       ├── categery_movie_repo.dart   # Category repository
│       ├── genre_movies_repo.dart     # Genre repository
│       └── trilar_movies_repo.dart    # Trailer repository
│
├── logic/                             # Business logic layer
│   └── cubit/cubit/                   # Cubit state management
│       ├── get_movies_cubit.dart       # Fetch & manage movies (popular, top rated, now playing)
│       ├── get_movies_state.dart       # Movies states (loading, loaded, error)
│       ├── search_movies_cubit.dart    # Search functionality
│       ├── search_movies_state.dart    # Search states
│       ├── get_categery_cubit.dart     # Category filtering
│       ├── get_categery_state.dart     # Category states
│       ├── trilar_movies_cubit.dart    # Fetch trailers
│       ├── trilar_movies_state.dart    # Trailer states
│       ├── add_fav_cubit.dart          # Add/remove favorites
│       └── add_fav_state.dart          # Favorites states
│
├── UI/                                # Presentation layer
│   ├── screens/                       # App screens
│   │   ├── welcom_screen.dart         # Welcome/onboarding screen with glassmorphism
│   │   ├── auth.dart                  # Auth state wrapper (auto-redirect)
│   │   ├── sign-In_screen.dart        # Sign in screen
│   │   ├── sign-Up_screen.dart        # Sign up screen
│   │   ├── home_page.dart             # Main home page
│   │   ├── movie_details_screen.dart  # Movie details with poster & info
│   │   ├── search_screen.dart         # Search input screen
│   │   ├── view_search_screen.dart    # Search results display
│   │   ├── fav_screen.dart            # Favorites list
│   │   ├── show_genere_movie.dart     # Movies filtered by genre
│   │   ├── trailer_screen.dart        # YouTube trailer player
│   │   ├── profile_screen.dart        # User profile & settings
│   │   └── app_info_screen.dart       # About the app
│   │
│   └── widgets/                       # Reusable UI components
│       ├── buttom_navigator_bar.dart   # Custom bottom nav (mobile) / nav rail (desktop)
│       ├── slide_show_movies.dart      # Carousel slider for movies
│       ├── movies_categery.dart        # Movie category section with title
│       ├── list_view_movies.dart       # Horizontal movie list
│       ├── grid_view_movies.dart       # Movie grid layout
│       ├── custom_list_genere_movies.dart # Genre chips list
│       ├── list_view_fav_movie.dart    # Favorite movie card
│       ├── add_to_fav.dart            # Favorite toggle button
│       └── custom_text_field.dart     # Styled text input field
│
└── helper/                            # Utility helpers
    ├── responsive_helper.dart         # Responsive breakpoints & sizing utilities
    ├── responsive_utils.dart          # Additional responsive utilities
    └── show_snak_bar.dart             # SnackBar helper function
```

---

## 🔄 State Management Flow

The app uses **BLoC/Cubit** pattern for state management:

```
User Action → Cubit Method → Repository → API Service → TMDB API
                                                            ↓
UI Update  ←  State Emitted  ←  Cubit  ←  Data Model  ←  Response
```

### Cubits Overview

| Cubit | Responsibility |
|---|---|
| `GetMoviesCubit` | Fetches popular, top rated, now playing movies & genres |
| `SearchMoviesCubit` | Handles movie search queries |
| `GetCategeryCubit` | Filters movies by genre/category |
| `TrilarMoviesCubit` | Fetches movie trailers from TMDB |
| `AddFavCubit` | Manages adding/removing favorites in Firestore |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.9.2` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** `^3.9.2` (included with Flutter)
- **Firebase Project** — [Create a Firebase project](https://console.firebase.google.com/)
- **TMDB API Key** — [Get your API key](https://www.themoviedb.org/settings/api)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/TarekHayan/Movie-App.git
   cd Movie-App
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Email/Password Authentication**
   - Enable **Cloud Firestore**
   - Run the FlutterFire CLI to configure:
     ```bash
     flutterfire configure
     ```
   - This will generate/update the `firebase_options.dart` file

4. **TMDB API Key**
   - Get your API key from [TMDB](https://www.themoviedb.org/settings/api)
   - Update the API key in `lib/constants/texts.dart`:
     ```dart
     final kapiKey = "YOUR_TMDB_API_KEY";
     ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 Supported Platforms

| Platform | Status |
|---|---|
| 📱 Android | ✅ Supported |
| 🍎 iOS | ✅ Supported |
| 🌐 Web | ✅ Supported |
| 🖥️ Windows | ✅ Supported |
| 🐧 Linux | ✅ Supported |
| 🍏 macOS | ✅ Supported |

---

## 🎨 Design System

- **Primary Color**: `#D12F26` (Brand Red)
- **Theme**: Dark Mode (`Brightness.dark`)
- **UI Style**: Glassmorphism on welcome screen, gradient overlays on movie details
- **Responsive Breakpoints**:
  - Mobile: `< 600px`
  - Tablet: `600px - 1024px`
  - Desktop: `> 1024px`

---

## 📡 API Endpoints

All API calls go through **TMDB API v3** (`https://api.themoviedb.org/3`):

| Endpoint | Description |
|---|---|
| `/movie/popular` | Get popular movies |
| `/movie/top_rated` | Get top rated movies |
| `/movie/now_playing` | Get currently playing movies |
| `/search/movie` | Search movies by query |
| `/genre/movie/list` | Get list of movie genres |
| `/movie/{id}/videos` | Get movie trailers |

---

## 🗄️ Firebase Structure

```
Firestore Database
└── users/
    └── {userId}/
        └── favorites/
            └── {movieId}/
                ├── id
                ├── title
                ├── poster_path
                ├── overview
                ├── release_date
                ├── vote_average
                └── original_language
```

---

## 📄 License

This project is open source and available for personal and educational use.

---

## 👨‍💻 Developer

**Tarek Hayan**

- GitHub: [@TarekHayan](https://github.com/TarekHayan)

---

<p align="center">
  Made with ❤️ using Flutter
</p>