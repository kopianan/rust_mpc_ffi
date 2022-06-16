import '../utils/secure_storage.dart';

abstract class NativeMpc {
   void setup();
  void connectToLocalHttp();
  Future<dynamic> proccessDkgString(int index);
  Future<dynamic> offlineSignWithJson(int index, String secretJsonString);
  Future<dynamic> sign(int index, String secretJsonString, String message);
}
