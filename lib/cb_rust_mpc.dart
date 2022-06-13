import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:isolate/isolate.dart';
import 'package:rust_mpc_ffi/input_converter.dart';

import 'ffi.dart' as native;

class CBRustMpc {
  static setup() {
    native.store_dart_post_cobject(NativeApi.postCObject);
  }

  void connectToLocalHttp(ReceivePort port) {
    native.http_local_run();
  }

  Future<dynamic> proccessDkgVector(int index) async {
    final completer = Completer<dynamic>();
    final sendPort = singleCompletePort(completer);
    native.wire_keygen(sendPort.nativePort, index);
    return completer.future;
  }

  Future<dynamic> proccessDkgString(int index) async {
    final completer = Completer<dynamic>();
    final sendPort = singleCompletePort(completer);
    native.wire_keygen(sendPort.nativePort, index);
    return completer.future;
  }

  // void proccessDkg(ReceivePort port, int index) {
  //   native.wire_keygen(port.sendPort.nativePort, index);
  // }

  void offlineSignWithVector(ReceivePort port, int index, Uint8List data) {
    var list = InputConverter.convertVectorToPointer(data);
    log("OFFLINE SIGN Vector");

    native.wire_presign(
      port.sendPort.nativePort,
      index,
      list[0] as Pointer<Uint8>,
      list[1] as int,
    );
  }

  Future<dynamic> offlineSignWithJson(
      int index, String secretJsonString) async {
    var list = InputConverter.convertStringToPointer(secretJsonString);
    final completer = Completer<dynamic>();
    final sendPort = singleCompletePort(completer);
    native.wire_presign(
      sendPort.nativePort,
      index,
      list[0] as Pointer<Uint8>,
      list[1] as int,
    );
    return completer.future;
  }

  Future<dynamic> sign(
      int index, String secretJsonString, String message) async {
    var list = InputConverter.convertStringToPointer(secretJsonString);
    final completer = Completer<dynamic>();
    final sendPort = singleCompletePort(completer);

    native.wire_sign(
      sendPort.nativePort,
      index,
      list[0] as Pointer<Uint8>,
      list[1] as int,
      message.toNativeUtf8(),
    );
    return completer.future;
  }
}
