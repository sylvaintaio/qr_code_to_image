#include "include/qr_code_to_image/qr_code_to_image_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "qr_code_to_image_plugin.h"

void QrCodeToImagePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  qr_code_to_image::QrCodeToImagePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
