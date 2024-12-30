import ImageToSocials from './NativeImageToSocials';

export function shareToInstagramStory(
  appId: string,
  backgroundImageUri: string,
  stickerImageUri?: string
): Promise<void> {
  return ImageToSocials.shareToInstagramStory(
    appId,
    backgroundImageUri,
    stickerImageUri
  );
}

export function shareToInstagram(imageUri: string): Promise<void> {
  return ImageToSocials.shareToInstagram(imageUri);
}
