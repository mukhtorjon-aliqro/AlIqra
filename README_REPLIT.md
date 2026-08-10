# AlIqra — Replit / Flutter test

Bu loyiha hozircha **Firebase'siz** ishlaydi. Login tugmalari mock (soxta) login qiladi:
Google / Apple / Telegram / Facebook / Email / Phone tugmalaridan biri bosilsa, test foydalanuvchi bilan MainScreen ochiladi.

## Muhim

Berilgan original ZIP'da `android/` va `web/` platform papkalari yo'q edi. Shu sababli original holatda `flutter build apk` ishlamaydi.

Bu variantda `replit_setup.sh` bor. Flutter SDK mavjud bo'lgan muhitda u:
1. `android/` va `web/` scaffolding'ini `flutter create` orqali yaratadi;
2. `flutter pub get` bajaradi.

## Replit'da

Shell'da:

```bash
chmod +x replit_setup.sh
./replit_setup.sh
```

So'ng web test:

```bash
flutter run -d chrome
```

Agar Chrome/device mavjud bo'lmasa, Replit workflow'da Flutter web server usulidan foydalanish mumkin; muhitga qarab `flutter run -d web-server --web-hostname 0.0.0.0 --web-port 3000` ishlatiladi.

## APK

Debug APK:

```bash
flutter build apk --debug
```

Release APK:

```bash
flutter build apk --release
```

Release AAB:

```bash
flutter build appbundle --release
```

Natijalar:

```text
build/app/outputs/flutter-apk/app-debug.apk
build/app/outputs/flutter-apk/app-release.apk
build/app/outputs/bundle/release/app-release.aab
```

## Hozircha qilinmagan

- Firebase
- haqiqiy Google/Apple/Telegram/Facebook login
- real AI backend
- production signing key
- store konfiguratsiyasi

Avval ilovaning UI va navigatsiyasini ishga tushiramiz. Firebase keyingi bosqichda ulanadi.
