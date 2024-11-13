import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  Platform,
} from 'react-native';
import { shareToInstagram } from 'react-native-image-to-socials';
import { launchImageLibrary } from 'react-native-image-picker';
import { useState } from 'react';

// Meta APPID: https://developers.facebook.com/docs/instagram-platform/sharing-to-stories/
const appId = '';

export default function App() {
  const [uri1, setUri1] = useState<string>('');
  const [uri2, setUri2] = useState<string | undefined>(undefined);
  return (
    <View style={styles.container}>
      <TouchableOpacity
        onPress={async () => {
          const result = await launchImageLibrary({
            mediaType: 'photo',
            selectionLimit: 1,
          });

          if (result.didCancel) return;
          if (result.errorCode) return;
          if (!result.assets || result.assets.length === 0) return;

          const asset = result.assets[0];
          if (!asset || !asset.uri) return;

          console.log('Selected image:');
          console.log(asset);

          const normalizedUri =
            Platform.OS === 'ios'
              ? asset.uri.replace('file://', '')
              : asset.uri;
          console.log(normalizedUri);
          setUri1(normalizedUri);
        }}
        style={{
          backgroundColor: 'green',
          height: 80,
          width: 80,
          borderRadius: 12,
        }}
      >
        <Text>Set Background</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={async () => {
          const result = await launchImageLibrary({
            mediaType: 'photo',
            selectionLimit: 1,
          });

          if (result.didCancel) return;
          if (result.errorCode) return;
          if (!result.assets || result.assets.length === 0) return;

          const asset = result.assets[0];
          if (!asset || !asset.uri) return;

          console.log('Selected image:');
          console.log(asset);

          const normalizedUri =
            Platform.OS === 'ios'
              ? asset.uri.replace('file://', '')
              : asset.uri;
          console.log(normalizedUri);
          setUri2(normalizedUri);
        }}
        style={{
          backgroundColor: 'green',
          height: 80,
          width: 80,
          borderRadius: 12,
        }}
      >
        <Text>Set Sticker</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={async () => {
          if (uri2 == null) {
            shareToInstagram(appId, uri1);
          } else {
            shareToInstagram(appId, uri1, uri2);
          }
        }}
        style={{
          backgroundColor: 'green',
          height: 80,
          width: 80,
          borderRadius: 12,
        }}
      >
        <Text>Share to Insta</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    gap: 12,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'red',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
