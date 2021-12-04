import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:integration_test/integration_test.dart';
import 'package:skm_services/main.dart' as app;

void main() {
  testWidgets('find and tap on the start button, verify page transition',
      (WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Start'), findsOneWidget);

    final Finder button = find.text('Start');

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Kundendaten'), findsOneWidget);
  });
}
