import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const storage = FlutterSecureStorage();

  static Future saveSecretKey(String key, String data) async {
    try {
      await storage.write(
        key: key,
        value: data,
      );
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<String?> loadSecretKey(String key) async {
    var result = await storage.read(key: key);
    if (result != null) {
      return result;
    }
    return null;
  }
}
