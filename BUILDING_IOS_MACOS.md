# Building Lexora for iOS and macOS

The iOS and macOS projects under `ios/` and `macos/` are fully configured
(app name, icons, bundle settings) — they just haven't been built into
installable binaries yet, since that requires Xcode, which only runs on
macOS. If you have a Mac, here's how to produce a real install for each
platform.

## Prerequisites

- A Mac running a recent version of macOS.
- [Xcode](https://apps.apple.com/us/app/xcode/id497799835) installed from
  the App Store, plus its command-line tools:
  ```
  xcode-select --install
  ```
- [Flutter](https://docs.flutter.dev/get-started/install/macos) installed
  and on your `PATH`. Confirm with `flutter doctor` — it should show a
  green checkmark for both "Flutter" and "Xcode".
- An [Apple Developer account](https://developer.apple.com/) (free tier is
  enough for local/personal installs; a paid membership is required to
  distribute outside your own devices — e.g. via TestFlight or the App
  Store).

## Get the code

```
git clone https://github.com/Bill2232/Oxford-3000-words-app.git
cd Oxford-3000-words-app
flutter pub get
```

## macOS

```
flutter build macos --release
```

This produces `build/macos/Build/Products/Release/Lexora.app`. To
distribute it as a `.dmg` you can double-click to install:

1. Open **Disk Utility** → **File > New Image > Image from Folder…**,
   select the `Release` folder above, and save it as `Lexora.dmg`
   (or use `create-dmg`, a small open-source CLI, for a nicer
   drag-to-Applications layout).
2. The app is unsigned by default, so on first launch macOS Gatekeeper
   will block it — right-click the app and choose **Open** once to
   approve it (or sign it with your Apple Developer certificate to avoid
   this entirely: `codesign --deep --force --sign "Developer ID
   Application: Your Name" Lexora.app`).

## iOS

```
flutter build ipa --release
```

This needs a valid signing setup first:

1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select the **Runner** target → **Signing & Capabilities**, and choose
   your Apple Developer team. Xcode will manage a provisioning profile
   for you.
3. Re-run `flutter build ipa --release` from the terminal — the signed
   `.ipa` lands in `build/ios/ipa/`.

From there:
- **Install on your own device**: drag the `.ipa` onto a device in
  Xcode's **Devices and Simulators** window, or use `flutter install`
  with the device connected over USB.
- **Distribute to others**: upload the `.ipa` via
  **Xcode > Window > Organizer**, or `xcrun altool`/`xcrun notarytool`,
  to TestFlight or the App Store — this requires the paid Apple Developer
  Program.

## Notes

- Neither platform's binary can be produced, signed, or notarized from
  Windows or Linux — Apple's toolchain is macOS-only.
- The app's bundle identifiers (`ios/Runner/Info.plist`'s
  `PRODUCT_BUNDLE_IDENTIFIER`, `macos/Runner/Configs/AppInfo.xcconfig`)
  are left at their current `com.wordly.*` values from this project's
  original setup — change them first if you're publishing under your own
  Apple Developer account and want a distinct app identity.
