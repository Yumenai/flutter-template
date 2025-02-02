const _basePath = 'assets/icons';

class IconAssetData {
  final String apple;
  final String facebook;
  final String google;

  const IconAssetData.dark()
      : apple = '$_basePath/apple.svg',
        facebook = '$_basePath/facebook.svg',
        google = '$_basePath/google.svg';

  const IconAssetData.light()
      : apple = '$_basePath/apple.svg',
        facebook = '$_basePath/facebook.svg',
        google = '$_basePath/google.svg';
}
