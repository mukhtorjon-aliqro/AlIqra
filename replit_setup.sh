#!/usr/bin/env bash
set -euo pipefail

echo "== AlIqra Replit setup =="

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter SDK topilmadi."
  echo "Replit muhitida Flutter SDK mavjud bo'lishi kerak."
  echo "Agar mavjud bo'lmasa, avval Flutter SDK ni o'rnating yoki Flutter o'rnatilgan Replit template'dan foydalaning."
  exit 1
fi

flutter --version

# This project archive intentionally contains Dart/lib code but not generated
# Android/Web platform folders. Generate only the missing platform scaffolding.
flutter create --platforms=android,web .

flutter pub get

echo
echo "Setup tugadi."
echo "Web test:  flutter run -d chrome"
echo "APK test:   flutter build apk --debug"
echo "Release APK: flutter build apk --release"
echo "Release AAB: flutter build appbundle --release"
