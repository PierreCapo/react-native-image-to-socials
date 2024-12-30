#import "ImageToSocials.h"
#import <Photos/Photos.h>

@implementation ImageToSocials
RCT_EXPORT_MODULE()

- (void)shareToInstagramStory:(NSString *)appId backgroundImageUri:(NSString *)backgroundImageUri stickerImageUri:(nullable NSString *)stickerImageUri
                      resolve:(RCTPromiseResolveBlock)resolve
                       reject:(RCTPromiseRejectBlock)reject {
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

- (void)shareToInstagram:(NSString *)imageUri resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject {
  UIImage *image = [UIImage imageWithContentsOfFile:imageUri];
  
  
  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    if (status == PHAuthorizationStatusAuthorized) {
      __block NSString *localIdentifier = nil;
      
      [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *creationRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        localIdentifier = creationRequest.placeholderForCreatedAsset.localIdentifier;
      } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
          
          NSString *url = [NSString stringWithFormat:@"instagram://library?LocalIdentifier=%@", localIdentifier];
          NSURL *instagramURL = [NSURL URLWithString: url];
          dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:instagramURL
                                               options:@{}
                                     completionHandler:^(BOOL success) {
              if (success) {
                NSLog(@"Opened Instagram successfully.");
              } else {
                NSLog(@"Failed to open Instagram.");
              }
            }];
          });
        } else {
          NSLog(@"Error saving image: %@", error.localizedDescription);
        }
      }];
    } else {
      NSLog(@"Authorization not granted.");
    }}];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeImageToSocialsSpecJSI>(params);
}

@end
