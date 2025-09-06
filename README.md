📒 Notes Application
A simple and efficient Notes Application built with Flutter. It allows users to create, edit, and manage their notes with a clean interface. The app integrates SQLite for local database storage and uses Shared Preferences for secure login and signup functionality.
🚀 Features
🔑 User Authentication
Signup and Login with Shared Preferences.
Secure session management.
📝 Notes Management
Add, edit, and delete notes.
Save notes locally using SQLite.
Persistent storage even after app restart.
🎨 User Interface
Simple and minimal design.
User-friendly navigation.
🛠️ Tech Stack
Flutter – Cross-platform framework
Dart – Programming language
SQLite – Local database for storing notes
Shared Preferences – Lightweight storage for authentication
📂 Project Structure
lib/
│── main.dart              # Entry point
│── screens/               # Login, Signup, Notes screens
│── database/              # SQLite helper
│── helpers/                 # Shared preferences helper
⚙️ Installation & Setup
Clone the repository:
git clone https://github.com/your-username/flutter-notes-app.git
cd flutter-notes-app
Install dependencies:
flutter pub get
Run the app:
flutter run
