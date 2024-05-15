#ifndef FLUTTER_PLUGIN_QR_CODE_TO_IMAGE_PLUGIN_H_
#define FLUTTER_PLUGIN_QR_CODE_TO_IMAGE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace qr_code_to_image {

class QrCodeToImagePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  QrCodeToImagePlugin();

  virtual ~QrCodeToImagePlugin();

  // Disallow copy and assign.
  QrCodeToImagePlugin(const QrCodeToImagePlugin&) = delete;
  QrCodeToImagePlugin& operator=(const QrCodeToImagePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace qr_code_to_image

#endif  // FLUTTER_PLUGIN_QR_CODE_TO_IMAGE_PLUGIN_H_
