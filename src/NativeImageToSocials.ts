import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  shareToInstagramStory(
    appId: string,
    backgroundImageUri: string,
    stickerImageUri?: string
  ): Promise<void>;

  shareToInstagram(imageUri: string): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('ImageToSocials');