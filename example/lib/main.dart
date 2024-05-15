// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_to_image/qr_code_to_image.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textQr = TextEditingController();
  String qrCodeResult = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Convert Qr code to image"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                TextFormField(
                  controller: textQr,
                  minLines: 1,
                  maxLines: 10,
                  style:const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Enter your text",
                    label: Text("Enter your text"),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Generate Qr code
                GestureDetector(
                  onTap: (){
                    QrCodeToImage.showQrCodeScreen(context, textQrCode: textQr.text.trim(),textButton: "Convert Qr code to image and share", colorWidgetTest: Colors.pink);
                  },
                  child: Container(
                    height: 50,
                    color: Colors.pink,
                    child: const Center(
                      child: Text("Generate Qr code",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Scan Qr code
                GestureDetector(
                  onTap: () {
                    QrCodeToImage.scanQrCode(lineColor: "#ff6666",cancelButtonText: "Anuler").then((value) {
                      if(value!.isNotEmpty){
                        setState(() {
                          qrCodeResult = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 1)
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner, color: Colors.pink),
                          SizedBox(width: 10),
                          Text("Scan QR Code", style: TextStyle(color: Colors.pink)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Scan BarCode code
                GestureDetector(
                  onTap: () {
                    QrCodeToImage.scanBarCode(lineColor: "#ff6666",cancelButtonText: "Anuler").then((value) {
                      if(value!.isNotEmpty){
                        setState(() {
                          qrCodeResult = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    color: Colors.pinkAccent,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Scan BarCode", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                // Display Qr code and copied
                if(qrCodeResult.isNotEmpty)...[
                  const SizedBox(height: 20),
                  SelectableText(
                    qrCodeResult,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    onTap: () {
                      if (qrCodeResult.isNotEmpty && qrCodeResult.startsWith("http")) {
                        launchUrl();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: qrCodeResult.isNotEmpty ? copyResult : null,
                    child: const Text("Copy Result", style: TextStyle(color: Colors.pink)),
                  ),
                ],
              ],
            ),
          ),
        )
    );
  }
  void launchUrl() async {
    if (await canLaunchUrl(Uri.parse(qrCodeResult))) {
      await launch(qrCodeResult);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid URL')));
    }
  }

  void copyResult() {
    Clipboard.setData(ClipboardData(text: qrCodeResult));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Text copied to clipboard')));
  }
}



