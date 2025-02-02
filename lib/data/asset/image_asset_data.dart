const _rootPath = 'assets/images';

class ImageAssetData {
  final String appLogo;
  final String appLogoTransparent;

  const ImageAssetData.dark()
      : appLogo = '$_rootPath/app-logo.png',
        appLogoTransparent = '$_rootPath/app-logo-transparent.png';

  const ImageAssetData.light()
      : appLogo = '$_rootPath/app-logo.png',
        appLogoTransparent = '$_rootPath/app-logo-transparent.png';
}
