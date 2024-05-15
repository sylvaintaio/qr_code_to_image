import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qr_code_to_image_method_channel.dart';

abstract class QrCodeToImagePlatform extends PlatformInterface {
  /// Constructs a QrCodeToImagePlatform.
  QrCodeToImagePlatform() : super(token: _token);

  static final Object _token = Object();

  static QrCodeToImagePlatform _instance = MethodChannelQrCodeToImage();

  /// The default instance of [QrCodeToImagePlatform] to use.
  ///
  /// Defaults to [MethodChannelQrCodeToImage].
  static QrCodeToImagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QrCodeToImagePlatform] when
  /// they register themselves.
  static set instance(QrCodeToImagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
