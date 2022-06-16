import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:isolate/isolate.dart';
import 'package:rust_mpc_ffi/src/native_mpc.dart';

import 'package:rust_mpc_ffi/ffi.dart' as native;
import 'package:rust_mpc_ffi/utils/secure_storage.dart';

import '../utils/input_converter.dart';

class CBRustMpc extends NativeMpc {
  SecureStorage storage = SecureStorage();
  @override
  void setup() {
    native.store_dart_post_cobject(NativeApi.postCObject);
  }

  @override
  void connectToLocalHttp() {
    native.http_local_run();
  }

  @override
  Future<dynamic> proccessDkgString(int index) async {
    final completer = Completer<dynamic>();
    final sendPort = singleCompletePort(completer);
    native.wire_keygen(sendPort.nativePort, index);
    final privateKey = await completer.future;

    return json.encode(json.decode(privateKey.toString())['y_sum_s']);
  }

  @override
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

  @override
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
