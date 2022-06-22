import 'dart:isolate';
import 'dart:typed_data';

import '../models/rsv_model.dart';
import '../utils/secure_storage.dart';

abstract class NativeMpc {
  void setup();
  void connectToLocalHttp();
  Future<dynamic> proccessDkgString(int index);
  Future<dynamic> offlineSignWithJson(int index, String secretJsonString);
  Future<RSVModel> sign(int index, String presignKey, Uint8List payload);
}
