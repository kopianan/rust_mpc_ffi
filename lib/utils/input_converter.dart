import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

class InputConverter {
  ///[0] is [data] [1] is [dataLength]
  static List convertVectorToPointer(Uint8List secret) {
    final Pointer<Uint8> result = calloc.allocate<Uint8>(secret.length + 1);
    final Uint8List nativeBytes = result.asTypedList(secret.length + 1);
    nativeBytes.setAll(0, secret);
    nativeBytes[secret.length] = 0;
    Pointer<Uint8> data = result.cast();
    int dataLength = secret.length;
    return [data, dataLength];
  }

  static List convertStringToPointer(String jsonString) {
    List<int> list = jsonString.codeUnits;
    final Pointer<Uint8> result = calloc.allocate<Uint8>(list.length + 1);
    final Uint8List nativeBytes = result.asTypedList(list.length + 1);
    nativeBytes.setAll(0, list);
    nativeBytes[list.length] = 0;

    Pointer<Uint8> data = result.cast();
    int dataLength = list.length;

    return [data, dataLength];
  }

  // static List convertUintToPointer(Uint8List uintData) {
  //   final Pointer<Uint8> result = calloc.allocate<Uint8>(uintData.length + 1);
  //   final Uint8List nativeBytes = result.asTypedList(uintData.length + 1);
  //   nativeBytes.setAll(0, uintData);
  //   nativeBytes[uintData.length] = 0;

  //   Pointer<Uint8> data = result.cast();
  //   int dataLength = uintData.length;

  //   return [data, dataLength];
  // }
}
