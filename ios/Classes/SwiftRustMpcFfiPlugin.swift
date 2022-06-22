import Flutter
import UIKit

public class SwiftRustMpcFfiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "rust_mpc_ffi", binaryMessenger: registrar.messenger())
    let instance = SwiftRustMpcFfiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }

  public func dummyMethodToEnforceBundling() {
    // This will never be executed
    
    http_local_run( );
    wire_keygen(1,1); 
    wire_presign(1,1,[0x0, 0x0, 0x5, 0x0],1);
    wire_sign(1, 1, [0x0, 0x0, 0x5, 0x0], 1, "");
  }

}
