#import <Flutter/Flutter.h>

@interface RustMpcFfiPlugin : NSObject<FlutterPlugin>
@end 
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
void test(int64_t port_);

void http_local_run(void);

void wire_keygen(int64_t port_, uint16_t index);

void wire_presign(int64_t port_,
                  uint16_t index,
                  const unsigned char *local_key_vec,
                  uintptr_t local_key_len);

void wire_sign(int64_t port_,
               uint16_t index,
               const unsigned char *presign_vec,
               uintptr_t presign_len,
               const char *tx_message);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
