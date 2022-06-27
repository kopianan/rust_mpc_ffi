/// bindings for `libgg20_mpc_ffi`

import 'package:ffi/ffi.dart' as ffi;
import 'dart:io';
import 'dart:ffi';

// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names
final DynamicLibrary _dl = _open();
DynamicLibrary _open() {
  if (Platform.isAndroid) return DynamicLibrary.open('libgg20_mpc_ffi.so');
  if (Platform.isIOS) return DynamicLibrary.executable();
  throw UnsupportedError('This platform is not supported.');
}

/// C function `http_local_run`.
void http_local_run() {
  _http_local_run();
}
final _http_local_run_Dart _http_local_run = _dl.lookupFunction<_http_local_run_C, _http_local_run_Dart>('http_local_run');
typedef _http_local_run_C = Void Function();
typedef _http_local_run_Dart = void Function();

/// C function `store_dart_post_cobject`.
void store_dart_post_cobject(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
) {
  _store_dart_post_cobject(ptr);
}
final _store_dart_post_cobject_Dart _store_dart_post_cobject = _dl.lookupFunction<_store_dart_post_cobject_C, _store_dart_post_cobject_Dart>('store_dart_post_cobject');
typedef _store_dart_post_cobject_C = Void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);
typedef _store_dart_post_cobject_Dart = void Function(
  Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> ptr,
);

/// C function `wire_keygen`.
void wire_keygen(
  int port_,
  int index,
) {
  _wire_keygen(port_, index);
}
final _wire_keygen_Dart _wire_keygen = _dl.lookupFunction<_wire_keygen_C, _wire_keygen_Dart>('wire_keygen');
typedef _wire_keygen_C = Void Function(
  Int64 port_,
  Uint16 index,
);
typedef _wire_keygen_Dart = void Function(
  int port_,
  int index,
);

/// C function `wire_presign`.
void wire_presign(
  int port_,
  int index,
  Pointer<Uint8> local_key_vec,
  int local_key_len,
) {
  _wire_presign(port_, index, local_key_vec, local_key_len);
}
final _wire_presign_Dart _wire_presign = _dl.lookupFunction<_wire_presign_C, _wire_presign_Dart>('wire_presign');
typedef _wire_presign_C = Void Function(
  Int64 port_,
  Uint16 index,
  Pointer<Uint8> local_key_vec,
  Uint64 local_key_len,
);
typedef _wire_presign_Dart = void Function(
  int port_,
  int index,
  Pointer<Uint8> local_key_vec,
  int local_key_len,
);

/// C function `wire_sign`.
void wire_sign(
  int port_,
  int index,
  Pointer<Uint8> presign_vec,
  int presign_len,
  Pointer<Uint8> keccak256_payload,
  int keccak256_payload_len,
) {
  _wire_sign(port_, index, presign_vec, presign_len, keccak256_payload, keccak256_payload_len);
}
final _wire_sign_Dart _wire_sign = _dl.lookupFunction<_wire_sign_C, _wire_sign_Dart>('wire_sign');
typedef _wire_sign_C = Void Function(
  Int64 port_,
  Uint16 index,
  Pointer<Uint8> presign_vec,
  Uint64 presign_len,
  Pointer<Uint8> keccak256_payload,
  Uint64 keccak256_payload_len,
);
typedef _wire_sign_Dart = void Function(
  int port_,
  int index,
  Pointer<Uint8> presign_vec,
  int presign_len,
  Pointer<Uint8> keccak256_payload,
  int keccak256_payload_len,
);
