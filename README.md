# 🎱 Tambola Multiplayer

A full-featured **Tambola / Housie** multiplayer game built with **Flutter + Firebase**.

---

## Features

- 🔴 **Multiplayer** — host creates a room, players join with a 4-digit code
- 🎯 **Real-time sync** — numbers broadcast via Cloud Firestore streams
- 🎟️ **Standard Tambola ticket** — 3×9, 5 numbers/row, correct column ranges
- ✅ **Win detection** — Top Line, Middle Line, Bottom Line, Early Five, Full House
- 🤖 **Auto-mark** — called numbers highlighted/marked automatically
- ⏱️ **Auto-caller** — host can auto-call every 3 seconds
- 🎮 **Solo practice** — offline mode in `TicketScreen`

---

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── firebase_options.dart      # Firebase config (auto-generated)
├── models/
│   ├── room_model.dart        # Firestore room document model
│   └── win_type.dart          # Win type enum + labels
├── services/
│   ├── firestore_service.dart # All Firestore operations
│   └── ticket_generator.dart  # Standard Tambola ticket generator
├── screens/
│   ├── home_screen.dart       # Create/Join room
│   ├── game_screen.dart       # Multiplayer game
│   └── ticket_screen.dart     # Solo offline play
└── widgets/
    ├── ticket_grid.dart       # 3×9 ticket grid widget
    ├── number_display.dart    # Current number + auto-mark toggle
    ├── history_strip.dart     # Horizontal scrollable history
    └── win_dialog.dart        # Win celebration dialog
```

---

## Setup Guide

### 1. Prerequisites

```bash
flutter --version   # Flutter 3.x+
firebase --version  # Firebase CLI
dart pub global activate flutterfire_cli
```

### 2. Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **Add project** → name it (e.g. `tambola-game`)
3. Enable **Cloud Firestore**:
   - Firestore Database → Create database → **Start in test mode**
4. Register your apps (Android, iOS, Web) in Project Settings

### 3. Configure Flutter with Firebase

```bash
# In the project root:
flutterfire configure
```

This auto-generates `lib/firebase_options.dart` and places `google-services.json` / `GoogleService-Info.plist` in the right locations.

### 4. Download google-services.json (Android)

Replace `android/app/google-services.json` with the real file from Firebase Console → Project Settings → Your Android app.

### 5. Run the App

```bash
flutter pub get
flutter run
```

---

## Firebase Hosting Deployment

### Build the web app

```bash
flutter build web --release
```

### Deploy

```bash
# First time setup:
firebase login
firebase init hosting
# → Public directory: build/web
# → Single-page app: Yes

# Deploy:
firebase deploy --only hosting
```

Your app will be live at: `https://YOUR_PROJECT_ID.web.app`

---

## Deploy Firestore Rules

```bash
firebase deploy --only firestore:rules
```

---

## Firestore Data Structure

```
rooms/{roomId}
  roomId:    "1234"
  numbers:   [5, 42, 17, ...]   // all called numbers
  current:   42                  // most recent number
  players:   3                   // player count
  status:    "waiting" | "playing" | "finished"
  hostId:    "host"
  createdAt: Timestamp
```

---

## How to Play

### Host
1. Open app → **Create Room**
2. Share the 4-digit Room ID with friends
3. Tap **Next** to call numbers one at a time, or **Auto** to call every 3s

### Player
1. Open app → Enter Room ID → **Join Room**
2. Your ticket is auto-generated
3. Tap a number to mark it manually, or enable **Auto Mark**
4. Win dialogs appear when you complete Top Line, Middle Line, Bottom Line, Early Five, or Full House

---

## Production Hardening

Before going public, update `firestore.rules` to require authentication:

```
allow update: if request.auth != null;
```

And add Firebase Auth:

```yaml
# pubspec.yaml
firebase_auth: ^4.x.x
```

---

## License

MIT
