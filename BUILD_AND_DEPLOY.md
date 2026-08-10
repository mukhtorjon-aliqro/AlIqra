# AlIqra — Build & Store Submission Guide

## 0. Prerequisites (one-time setup)
- Install **Flutter SDK** (stable channel): https://docs.flutter.dev/get-started/install
- Run `flutter doctor` and resolve every ❌ before continuing.
- Android builds: **Android Studio** + Android SDK + a Java JDK 17.
- iOS/macOS builds: a **Mac** with **Xcode** (App Store builds are only possible on macOS — there is no way around this).
- Create accounts:
  - **Google Play Console**: https://play.google.com/console ($25 one-time fee)
  - **Apple Developer Program**: https://developer.apple.com ($99/year)

## 1. Get the project running locally

> **Important:** The supplied source ZIP does not include generated `android/`, `ios/`, or `web/` platform folders. Before an APK build, run `flutter create` once to generate the platform scaffolding. This keeps the current `lib/` code unchanged.

If you are using the Replit-ready ZIP, run:

```bash
./replit_setup.sh
```

For a normal local Flutter checkout:

```bash
flutter create --platforms=android,web .
flutter pub get        # downloads provider, shared_preferences, etc.
flutter doctor -v       # confirm no blocking issues
flutter run             # launches on a connected device/emulator
```

## 2. Android — build the APK / AAB

### 2.1 Create your app signing key (once)
```bash
keytool -genkey -v -keystore ~/aliqra-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias aliqra
```
Keep this `.jks` file and its passwords **safe and backed up** — losing it means you can never update the app again under the same listing.

### 2.2 Configure signing
Create `android/key.properties`:
```
storePassword=<your store password>
keyPassword=<your key password>
keyAlias=aliqra
storeFile=/absolute/path/to/aliqra-release.jks
```
In `android/app/build.gradle`, load `key.properties` and set `signingConfigs.release` to use it (Flutter's default template has commented-out sections for this — uncomment and point them at the values above).

### 2.3 Set the application ID & app name
- `android/app/build.gradle` → `applicationId "com.yourcompany.aliqra"`
- `android/app/src/main/AndroidManifest.xml` → `android:label="AlIqra"`
- Replace launcher icons in `android/app/src/main/res/mipmap-*` (use Android Studio's Image Asset tool, or the `flutter_launcher_icons` package).

### 2.4 Build
```bash
# App Bundle (required by Google Play for new apps)
flutter build appbundle --release

# APK (useful for direct testing/sideloading)
flutter build apk --release
```
Output:
- `build/app/outputs/bundle/release/app-release.aab`
- `build/app/outputs/flutter-apk/app-release.apk`

### 2.5 Upload to Google Play
1. Go to **Play Console → Create app** → fill in name (AlIqra), language, category (Education).
2. Complete **App content**: Privacy Policy URL, Data safety form, Content rating questionnaire (important — this is an education app for children too), Target audience & content.
3. **Store listing**: screenshots (phone + tablet), feature graphic, short & full description (translate into your priority languages), app icon.
4. **Production → Create new release**, upload the `.aab` file, add release notes.
5. Submit for review. First review typically takes a few days.

## 3. iOS — build the IPA (macOS + Xcode required)

### 3.1 Open in Xcode
```bash
open ios/Runner.xcworkspace
```

### 3.2 Configure signing & identity
- In Xcode: select **Runner** target → **Signing & Capabilities**.
- Set your **Team** (from your paid Apple Developer account).
- Set a unique **Bundle Identifier**, e.g. `com.yourcompany.aliqra`.
- Set **Display Name** to "AlIqra" in `ios/Runner/Info.plist`.
- Add app icons via `ios/Runner/Assets.xcassets/AppIcon.appiconset` (or the `flutter_launcher_icons` package).

### 3.3 Register the app in App Store Connect
1. Go to https://appstoreconnect.apple.com → **My Apps → +** → New App.
2. Match the **Bundle ID** you set in Xcode, choose name "AlIqra", primary language, category (Education).

### 3.4 Build & archive
```bash
flutter build ipa --release
```
This produces `build/ios/ipa/aliqra.ipa` and (via Xcode's organizer flow) is the recommended path. Alternatively, in Xcode: **Product → Archive**, then use the **Organizer** window → **Distribute App → App Store Connect → Upload**.

### 3.5 Submit for review
1. In App Store Connect, go to the app → **TestFlight** (optional but recommended: invite testers first).
2. Once the build finishes processing, go to the app's **App Store** tab.
3. Fill in: description, keywords, screenshots (per device size), privacy policy URL, age rating (important — set correctly since this app targets children 4+ as well as adults), support URL.
4. Attach the uploaded build, then **Submit for Review**. Apple review usually takes 24–48 hours.

## 4. Notes specific to AlIqra
- Because the app targets **children (ages 4–6, 7–10, 11–15)**, both stores will ask extra questions:
  - Google Play: complete the **"Target audience and content"** and **Families policy** sections if you opt into the Designed for Families program.
  - Apple: set the correct **Age Rating** and consider **Kids Category** requirements (no third-party analytics/ads targeting children, parental gate for external links/purchases, etc.).
- Before submitting, replace all placeholder/mock logic:
  - Real OAuth SDKs for Google/Apple/Telegram/Facebook sign-in (see comments in `lib/providers/auth_provider.dart`).
  - A real backend for the AI Center features (SRS section 5) and for storing Profile/Progress data (SRS section 10 — encryption, backups).
- Test the app in **at least Arabic (RTL) and one Cyrillic language** to confirm layout mirrors and renders correctly before release.

## 5. Quick command reference
| Task | Command |
|---|---|
| Install dependencies | `flutter pub get` |
| Run on device/emulator | `flutter run` |
| Android release bundle | `flutter build appbundle --release` |
| Android release APK | `flutter build apk --release` |
| iOS release IPA | `flutter build ipa --release` |
| Check environment | `flutter doctor -v` |
