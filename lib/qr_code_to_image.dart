import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart' as qrCode;
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';


class QrCodeToImage {
  static Future<void> showQrCodeScreen(BuildContext context, {String? textQrCode,textButton,Color? colorWidgetTest}) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CreateQrCodeScreen(textQrCode: textQrCode!,textButton: textButton,colorWidgetTest: colorWidgetTest!),
    ));
  }

  static Future<void> convertQrCodeToImage(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = File("$directory/qrCode.png");
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles([imgFile.path], text: "Your text share");
    } catch (e) {
      if (kDebugMode) {
        print("Error converting QR code to image: $e");
      }
    }
  }


  static Future<String?> scanQrCode({String? lineColor, String? cancelButtonText}) async {
    try {
      return await FlutterBarcodeScanner.scanBarcode(lineColor??"#ff6666", cancelButtonText??"Cancel", true, ScanMode.QR);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      return null;
    }
  }

  static Future<String?> scanBarCode({String? lineColor, String? cancelButtonText}) async {
    try {
      return await FlutterBarcodeScanner.scanBarcode(lineColor??"#ff6666", cancelButtonText??"Cancel", true, ScanMode.BARCODE);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      return null;
    }
  }
}


class CreateQrCodeScreen extends StatefulWidget {
  final String textQrCode;
  final String textButton;
  final Color colorWidgetTest;
  const CreateQrCodeScreen({Key? key, required this.textQrCode,required this.textButton,required this.colorWidgetTest}) : super(key: key);

  @override
  State<CreateQrCodeScreen> createState() => _CreateQrCodeScreenState();
}

class _CreateQrCodeScreenState extends State<CreateQrCodeScreen> {
  final GlobalKey globalKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RepaintBoundary(
                key: globalKey,
                child: qrCode.QrImageView(
                  data: widget.textQrCode,
                  version: qrCode.QrVersions.auto,
                  size: 200,
                  gapless: false,
                  //foregroundColor: Colors.grey.shade700,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (cxt, err) {
                    return const Center(
                      child: Text("Error"),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => QrCodeToImage.convertQrCodeToImage(globalKey),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: widget.colorWidgetTest, width: 1)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share_outlined, color: widget.colorWidgetTest),
                      const SizedBox(width: 10),
                      Text(widget.textButton, style: TextStyle(color: widget.colorWidgetTest)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}