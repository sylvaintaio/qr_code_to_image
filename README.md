# qr_code_to_image

"QR_Code_to_Image" is a Flutter plugin that provides a range of features for working with QR codes. With this plugin, you can easily generate QR codes, display them on the screen, convert them into images, and share them with other users. Additionally, you have the ability to scan existing QR codes and copy their content.

Thanks to "QR_Code_to_Image", creating and managing QR codes becomes simple and efficient. Whether for professional or personal needs, this plugin offers a comprehensive solution for integrating QR code functionalities into your Flutter application

## Using

To generate a qr code, convert to image and share

import 'package:qr_code_to_image/qr_code_to_image.dart';

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


Explanation: 

textQrCode:  Text to convert to qr code

textButton: Share button text after converting to image

colorWidgetTest: This is the color of the share button after conversion to image, the color of the button border and the color of the button text.


To scan a qr code:

import 'package:qr_code_to_image/qr_code_to_image.dart';

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
        child: Text("Scan and Share QR Code", 
            style: TextStyle(
                color: Colors.pink
                )
            )
        ),
    ),
),



To scan a BarCode:

import 'package:qr_code_to_image/qr_code_to_image.dart';

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
        child: Text("Scan BarCode",
            style: TextStyle(
                color: Colors.pink
            )
            )
        ),
    ),
),
![Capture d'écran de mon application](https://github.com/sylvaintaio/qr_code_to_image/blob/main/Screenshot_20240515-154039.jpg)
![Capture d'écran de mon application](https://github.com/sylvaintaio/qr_code_to_image/blob/main/Screenshot_20240515-154045.jpg)
![Capture d'écran de mon application](https://github.com/sylvaintaio/qr_code_to_image/blob/main/Screenshot_20240515-154104.jpg)
![Capture d'écran de mon application](https://github.com/sylvaintaio/qr_code_to_image/blob/main/Screenshot_20240515-154110.jpg)
![Capture d'écran de mon application](https://github.com/sylvaintaio/qr_code_to_image/blob/main/Screenshot_20240515-154125.jpg)

