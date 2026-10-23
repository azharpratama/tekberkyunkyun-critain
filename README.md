# Critain - Mental Health Companion App

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?logo=supabase&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

Critain is a cross-platform mobile application providing a safe, supportive ecosystem for mental well-being. Built with **Flutter** and **Supabase (PostgreSQL with Row-Level Security)**, it enables real-time peer counseling, daily affirmation streams, anonymous storytelling, and gamified listener progression.

---

## ✨ Core Features

*   **Ruang Bercerita**: Real-time queue-based matchmaking connecting *Storytellers* (users seeking a listening ear) with peer *Listeners*, featuring anonymous end-to-end chat streams.
*   **Ruang Afirmasi**: Community-powered daily positive affirmation feed with real-time reactions and user submissions.
*   **Perpustakaan Cerita**: Curated library of user-submitted mental wellness stories and psychoeducational articles.
*   **Gamified Listener Progression**: Tiered badge progression (Bronze, Silver, Gold Listener) incentivizing compassionate community moderation and peer support.

---

## 📱 Download the App

Download the Android APK release to test on device:

👉 **[Download Critain APK](https://drive.google.com/file/d/1g-HtIZO_qg2_a6KOjcIIxldN4pLE8_83/view?usp=sharing)**

*(Note: Enable "Install from unknown sources" in device settings if prompted during installation)*

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

## Contributors & Academic Context

Developed by **Kelompok 9 Teknologi Berkembang**, Institut Teknologi Sepuluh Nopember (ITS):
- Rafindra Nabiel Fawwaz (`5026231024`)
- Azhar Aditya Pratama (`5026231084`)
- Firmansyah Adi Prasetyo (`5026231085`)
- Muhammad Fawwaz Al-Amien (`5026231092`)
- Muhammad Artha Maulana Suswanto (`5026231134`)
- Fachreza Aptadhi Kurniawan (`5026231135`)
- Muhammad Abyan Tsabit Amani (`5026231163`)

*Advisor:* Izzat Aulia Akbar, S.Kom., M.Eng., Ph.D.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


