
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_code_to_image_example/main.dart' as app;

class MockQrImage extends StatelessWidget {
  const MockQrImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Mock QrImage');
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test showQrCodeScreen function', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    // Tap the button to generate QR code
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the QR code screen is shown
    expect(find.text('Create Qr code screen'), findsOneWidget);
    expect(find.byType(MockQrImage), findsOneWidget);
  });
}
