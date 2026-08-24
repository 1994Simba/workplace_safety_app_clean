# Workplace Safety Mobile App

A modern Flutter application designed to streamline workplace hazard reporting, safety checks, and incident history tracking. Built for speed, clarity, and reliability, the app enables employees to quickly document hazards, attach photos, and maintain a complete history of safety‑related events.

---

## 🚀 Features

### 📝 Hazard Reporting
- Create detailed hazard reports  
- Add severity level, description, and timestamp  
- Attach photos using the device camera  
- Automatically saves to local storage (Hive)

### 📚 Hazard History
- Chronological list of all reported hazards  
- Auto‑refresh when new hazards are added  
- Delete individual hazard entries  
- Displays images, timestamps, severity, and descriptions  
- Uses a `GlobalKey` to refresh the history screen from other screens

### 📋 Safety Checklist
- Predefined safety checklist screen  
- Simple UI for quick daily safety verification

### 📊 Dashboard
- Overview of app sections  
- Entry point for reporting hazards, viewing history, and accessing checklists

### 🔐 Authentication
- Basic login screen  
- Simple navigation flow for authenticated sessions

---

## 🧱 Tech Stack

- **Flutter** (Dart)  
- **Hive** for local persistent storage  
- **Material Design**  
- **iOS & Android support**  
- **File & Image handling** via `dart:io`

---

## 📂 Project Structure

```text
lib/
│
├── main.dart
├── main_navigation.dart
│
├── dashboard_screen.dart
├── hazard_report_screen.dart
├── hazard_history_screen.dart
├── safety_checklist_screen.dart
└── login_screen.dart
```


## 🔧 Key Implementation Details

### Hazard History Refresh

\`\`\`dart
final GlobalKey<HazardHistoryScreenState> historyKey = GlobalKey();
historyKey.currentState?.refresh();
\`\`\`

### Local Storage

Hazards are stored in a Hive box named:

\`\`\`text
'hazards'
\`\`\`

Each hazard entry includes:
- title  
- description  
- severity  
- timestamp  
- imagePath  

---

## 📸 Image Handling

\`\`\`dart
File(imagePath).existsSync()
\`\`\`

---

## 🗑 Hazard Deletion

\`\`\`dart
box.delete(key);
loadHazards();
\`\`\`

---

## 🛠 Setup Instructions

### 1. Install dependencies
\`\`\`bash
flutter pub get
``\`

### 2. Initialize Hive
Ensure Hive boxes are opened in `main.dart` before running the app.

### 3. Run the app
```bash
flutter run
```

---

## 📱 Platform Notes

### iOS
`speech_to_text` currently does not support Swift Package Manager.  
This is only a warning and does not block builds.

### Android
Fully supported.

---

## 🤝 Contributing

Pull requests are welcome.  
For major changes, please open an issue first to discuss what you would like to modify.

---

## 📄 License

This project is licensed under the MIT License.

---

## 👤 Author

**Integrity**  
Flutter Developer  
Germany
