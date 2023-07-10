// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/services.dart';

class BarcodeScannerPlugin {
  static const EventChannel _eventChannel =
      EventChannel('app.dsic.barcodetray.BARCODE_BR_DECODING_DATA');

  static Stream<String> get barcodeDataStream {
    return _eventChannel.receiveBroadcastStream().map<String>((event) {
      final barcodeData = event['EXTRA_BARCODE_DECODED_DATA'] as String?;
      return barcodeData ?? '';
    });
  }
}
