import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:isolate/isolate.dart';
import 'package:rust_mpc_ffi/models/rsv_model.dart';
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

    // return json.encode(json.decode(privateKey.toString())['y_sum_s']);
    return privateKey.toString();
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
  Future<RSVModel> sign(int index, String presignKey, Uint8List payload) async {
    var presignPointer = InputConverter.convertStringToPointer(presignKey);
    var payloadPointer = InputConverter.convertVectorToPointer(payload);
    final completer = Completer<RSVModel>();
    // final sendPort = singleCompletePort(completer);
    // singleCompletePort(completer)

    final port = ReceivePort();

    native.wire_sign(
      port.sendPort.nativePort,
      index,
      presignPointer[0] as Pointer<Uint8>,
      presignPointer[1] as int,
      payloadPointer[0] as Pointer<Uint8>,
      payloadPointer[1] as int,
    );

    List<dynamic> response = [];

    port.listen((e) {
      response.add(e);
      if (response.length == 3) {
        var rsv = RSVModel(
            r: response[0].toString(),
            s: response[1].toString(),
            v: response[2].toString());
        completer.complete(rsv);
      }
    });

    return completer.future;
  }
}
