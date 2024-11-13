#import "ImageToSocials.h"

@implementation ImageToSocials
RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_EXPORT_METHOD(shareToInstagram:(NSString *)appId
                  backgroundImageUri:(NSString *)backgroundImageUri
                  stickerImageUri:(nullable NSString *)stickerImageUri
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  UIImage *backgroundUIImage = [UIImage imageWithContentsOfFile:backgroundImageUri];
  NSData *backgroundImage = UIImagePNGRepresentation(backgroundUIImage);

  NSArray *pasteboardItems;
  if (stickerImageUri == nil) {
    // Attach the pasteboard items
    pasteboardItems = @[@{@"com.instagram.sharedSticker.backgroundImage" : backgroundImage}];
  } else {
    UIImage *stickerUIImage = [UIImage imageWithContentsOfFile:stickerImageUri];
    NSData *stickerImage = UIImagePNGRepresentation(stickerUIImage);
    // Attach the pasteboard items
    pasteboardItems = @[@{@"com.instagram.sharedSticker.backgroundImage" : backgroundImage,
                                   @"com.instagram.sharedSticker.stickerImage" : stickerImage}];
  }

  NSURL *urlScheme = [NSURL URLWithString:[NSString stringWithFormat:@"instagram-stories://share?source_application=%@", appId]];

  if ([[UIApplication sharedApplication] canOpenURL:urlScheme])
  {

    // Set pasteboard options
    NSDictionary *pasteboardOptions = @{UIPasteboardOptionExpirationDate : [[NSDate date] dateByAddingTimeInterval:60 * 5]};

    // This call is iOS 10+, can use 'setItems' depending on what versions you support
    [[UIPasteboard generalPasteboard] setItems:pasteboardItems options:pasteboardOptions];

    [[UIApplication sharedApplication] openURL:urlScheme options:@{} completionHandler:nil];
  }
  else
  {
      // Handle error cases
  }
}


@end
