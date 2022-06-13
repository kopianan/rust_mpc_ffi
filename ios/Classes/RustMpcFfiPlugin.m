#import "RustMpcFfiPlugin.h"
#if __has_include(<rust_mpc_ffi/rust_mpc_ffi-Swift.h>)
#import <rust_mpc_ffi/rust_mpc_ffi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rust_mpc_ffi-Swift.h"
#endif

@implementation RustMpcFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRustMpcFfiPlugin registerWithRegistrar:registrar];
}
@end
