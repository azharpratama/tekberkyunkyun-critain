# Critain - Mental Health Companion App

Critain is a mobile application designed to provide a safe and supportive ecosystem for mental well-being. It connects users who need to be heard with compassionate listeners (introverts/peers) and provides tools for self-affirmation and storytelling.

Built with **Flutter** and powered by **Supabase**.

---

## Project Description (Deskripsi Proyek)

Critain aims to reduce the stigma around mental health by providing anonymous, accessible, and engaging tools. The app features:

*   **Ruang Bercerita**: A real-time chat platform connecting *Storytellers* (users needing to vent) with *Listeners*. It features a queue-based matchmaking system and anonymous messaging.
*   **Ruang Afirmasi**: A positive space where users can receive daily affirmations or send supportive messages to the community.
*   **Perpustakaan Cerita**: A library of user-submitted stories and mental health articles to inspire and educate.
*   **Gamification**: Users earn points and badges (e.g., Bronze, Silver, Gold Listener) for helping others.

---

## Our Team (Tim Pengembang)

**Kelompok 9 Teknologi Berkembang**

*   Rafindra Nabiel Fawwaz (5026231024)
*   Azhar Aditya Pratama (5026231084)
*   Firmansyah Adi Prasetyo (5026231085)
*   Muhammad Fawwaz Al-Amien (5026231092)
*   Muhammad Artha Maulana Suswanto (5026231134)
*   Fachreza Aptadhi Kurniawan (5026231135)
*   Muhammad Abyan Tsabit Amani (5026231163)

**Dosen Pengampu**\
Izzat Aulia Akbar, S.Kom., M.Eng., Ph.D.

**INSTITUT TEKNOLOGI SEPULUH NOPEMBER**\
SURABAYA\
TAHUN AJARAN 2025/2026

---

---

## Download the App (Unduh Aplikasi)

You can download the latest version of the app (APK) directly from this repository and install it on your Android device.

1.  Go to the `build/app/outputs/flutter-apk/` directory in this repository (or check the Releases section if available).
2.  Download the `app-release.apk` file.
3.  Transfer the file to your Android device.
4.  Open the file on your device and follow the prompts to install.
    *   *Note: You may need to enable "Install unknown apps" or "Install from unknown sources" in your device settings.*

---

## Installation (Cara Instalasi)

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.0.0 or higher)
*   [Git](https://git-scm.com/)
*   A Supabase project (for backend)

### Steps

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/azharpratama/tekberkyunkyun-critain.git
    cd tekberkyunkyun-critain
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Environment Setup**
    Create a `.env` file in the root directory and add your Supabase credentials:
    ```env
    SUPABASE_URL=your_supabase_url
    SUPABASE_ANON_KEY=your_supabase_anon_key
    ```
4. **Database Setup**
    This project uses Supabase. To set up the database schema:
    1.  Go to your [Supabase Dashboard](https://supabase.com/dashboard).
    2.  Navigate to the **SQL Editor** tab.
    3.  Open the `migration.sql` file from this repository.
    4.  Copy the entire content and paste it into the SQL Editor.
    5.  Click **Run** to generate all tables, policies, and triggers.

---

## How to Run (Cara Menjalankan)

### Mobile (Android/iOS)
Connect your device or start an emulator, then run:

```bash
flutter run
```

### Web
To run on the web server (development mode):

```bash
flutter run -d web-server
```

---

## Folder Structure (Struktur Folder)

The project follows a **Feature-First Architecture** combined with **MVVM (Model-View-ViewModel)**.

```
lib/
├── core/               # Core utilities, theme configuration, and constants
│   ├── constants/      # App-wide string keys, dimensions
│   ├── theme/          # App colors, text styles, light/dark themes
│   └── utils/          # Helper functions and extensions
│
├── data/               # Data layer (repositories, data sources) NOT CURRENTLY EXTANT
│
├── models/             # Data models (PODOs) mapping to database tables
│   ├── user.dart
│   ├── message.dart
│   └── ...
│
├── screens/            # UI Screens organized by feature
│   ├── auth/           # Login, Register
│   ├── main/           # Home, Navigation Container
│   └── features/
│       ├── ruang_bercerita/    # Matchmaking & Chat screens
│       ├── ruang_afirmasi/     # Affirmation generator screens
│       ├── perpustakaan_cerita/# Story reading & listing screens
│       └── profile/            # User profile & settings
│
├── services/           # Backend interactions (Supabase logic)
│   ├── auth_service.dart
│   ├── ruang_bercerita_service.dart
│   └── ...
│
├── viewmodels/         # State management (Provider) logic
│   ├── auth_viewmodel.dart
│   ├── ruang_bercerita_viewmodel.dart
│   └── ...
│
├── widgets/            # Reusable UI components
│   ├── common/         # Generic buttons, inputs, dialogs
│   ├── ruang_bercerita/# Feature-specific widgets (Chat Bubbles, etc.)
│   └── ...
│
└── main.dart           # Application entry point
```

---

## Tech Stack

*   **Frontend**: Flutter (Dart)
*   **State Management**: Provider
*   **Backend**: Supabase (PostgreSQL, Authentication, Realtime, Storage). See [Database ERD](ERD.md) for schema details.
*   **Navigation**: Flutter Navigator 1.0 (Push/Pop)

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


