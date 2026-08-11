import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:aliqra/app.dart';
import 'package:aliqra/l10n/locale_provider.dart';
import 'package:aliqra/providers/auth_provider.dart';

void main() {
  testWidgets('AlIqra starts on the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const AlIqraApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AlIqra'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}