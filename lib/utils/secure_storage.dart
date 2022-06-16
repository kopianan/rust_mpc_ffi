import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<void> saveKey(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String?> readKey(String key) async {
    try {
      final result = await storage.read(key: key);
      return result;
    } on PlatformException catch (e) {
      throw Exception(e.message);
    }
  }
}
