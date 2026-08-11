# AlIqra on Replit

## Run the app

The project is a Flutter web app. The configured `Start application` workflow
runs:

```bash
flutter pub get
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000
```

Open the Replit Preview to view the app. The current preview starts on the
mock login screen.

## Project setup

The imported source did not include Flutter platform folders. The existing
`replit_setup.sh` script generates the Android and web scaffolding and fetches
the Dart packages:

```bash
bash replit_setup.sh
```

The project currently uses mock authentication and does not require secrets or
external services to run.