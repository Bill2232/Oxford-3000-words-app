# Lexora

Practice the Oxford 3000 word list with spelling drills, pronunciation,
and progress tracking. Built with Flutter.

**[Try it in your browser](https://bill2232.github.io/Oxford-3000-words-app/)**

## Download

| Platform | Download |
|---|---|
| Windows | [Lexora-Windows-Setup.exe](https://github.com/Bill2232/Oxford-3000-words-app/releases/latest/download/Lexora-Windows-Setup.exe) |
| Android | [Lexora-Android.apk](https://github.com/Bill2232/Oxford-3000-words-app/releases/latest/download/Lexora-Android.apk) |
| Web | [bill2232.github.io/Oxford-3000-words-app](https://bill2232.github.io/Oxford-3000-words-app/) — no install needed |
| iOS / macOS | Not yet available as a download — see [BUILDING_IOS_MACOS.md](BUILDING_IOS_MACOS.md) to build from source on a Mac |

Android will warn that the app is from an "unknown source" (or "unrecognized app" on Windows) since it isn't signed with a Play Store / paid code-signing certificate — this is expected for a GitHub-distributed app; choose "Install anyway" / "More info > Run anyway" to proceed.

## Features

- Full Oxford 3000 word list, searchable, with tap-to-pronounce audio on every word
- Spelling practice with automatic pronunciation, a British/American accent quick-switch, and a choice of Wordle-style letter boxes or a plain text field
- Progress tracking: per-word mastery levels, CEFR-level breakdown, weak words, streaks, and a daily practice goal
- Sound effects (with a volume control) for correct/incorrect answers, mastering a word, and hitting your daily goal
- Six color themes

## Building from source

```
git clone https://github.com/Bill2232/Oxford-3000-words-app.git
cd Oxford-3000-words-app
flutter pub get
flutter run            # or: flutter build <windows|apk|web|macos|ipa>
```

For iOS and macOS specifically, see [BUILDING_IOS_MACOS.md](BUILDING_IOS_MACOS.md) — both require a Mac with Xcode.

The Windows installer is built separately with [Inno Setup](https://jrsoftware.org/isinfo.php):

```
flutter build windows --release
iscc windows\installer\lexora.iss
```
