import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qr_code_to_image_platform_interface.dart';

/// An implementation of [QrCodeToImagePlatform] that uses method channels.
class MethodChannelQrCodeToImage extends QrCodeToImagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qr_code_to_image');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
