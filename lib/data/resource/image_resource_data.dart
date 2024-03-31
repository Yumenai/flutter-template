const _basePath = 'assets/image';

class ImageResourceData {
  final String appLogo;
  final String appSplash;

  const ImageResourceData.dark()
      : appLogo = '$_basePath/app-logo.png',
        appSplash = '$_basePath/app-splash.png';

  const ImageResourceData.light()
      : appLogo = '$_basePath/app-logo.png',
        appSplash = '$_basePath/app-splash.png';
}
