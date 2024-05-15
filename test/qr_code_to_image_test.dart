import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_code_to_image/qr_code_to_image.dart';
import 'package:qr_code_to_image/qr_code_to_image_platform_interface.dart';
import 'package:qr_code_to_image/qr_code_to_image_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MockQrCodeToImagePlatform with MockPlatformInterfaceMixin implements QrCodeToImagePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QrCodeToImagePlatform initialPlatform = QrCodeToImagePlatform.instance;

  test('$MethodChannelQrCodeToImage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQrCodeToImage>());
  });

  testWidgets('Test showQrCodeScreen function', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () async {
                await QrCodeToImage.showQrCodeScreen(context,textButton: "Convert Qr code to image and share",colorWidgetTest: Colors.pink);
              },
              child: const Text('Test Button'),
            );
          },
        ),
      ),
    ));

    // Tap the test button and trigger the navigation
    await tester.tap(find.text('Test Button'));
    await tester.pumpAndSettle();

    // Verify that the QR code screen is shown
    expect(find.text('Create Qr code screen'), findsOneWidget);
    expect(find.byType(QrImage), findsOneWidget);
  });
}
