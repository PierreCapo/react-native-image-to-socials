
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNImageToSocialsSpec.h"

@interface ImageToSocials : NSObject <NativeImageToSocialsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface ImageToSocials : NSObject <RCTBridgeModule>
#endif

@end
