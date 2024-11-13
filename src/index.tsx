import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-image-to-socials' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const ImageToSocials = NativeModules.ImageToSocials
  ? NativeModules.ImageToSocials
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function shareToInstagram(
  appId: string,
  backgroundImageUri: string,
  stickerImageUri: string
): Promise<void> {
  return ImageToSocials.shareToInstagram(
    appId,
    backgroundImageUri,
    stickerImageUri
  );
}
