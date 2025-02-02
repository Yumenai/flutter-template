import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/asset/icon_asset_data.dart';
import '../data/asset/image_asset_data.dart';

class ResourceManager with ChangeNotifier {
  static ResourceManager of(final BuildContext context) {
    return Provider.of<ResourceManager>(context);
  }

  ResourceManager();

  IconAssetData _icon = const IconAssetData.light();
  IconAssetData get icon => _icon;

  ImageAssetData _image = const ImageAssetData.light();
  ImageAssetData get image => _image;

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void updateTheme(final ThemeMode theme) {
    _themeMode = theme;

    switch (themeMode) {
      case ThemeMode.system:
        updateBrightness(
          WidgetsBinding.instance.platformDispatcher.platformBrightness,
        );
        break;
      case ThemeMode.light:
        updateBrightness(Brightness.light);
        break;
      case ThemeMode.dark:
        updateBrightness(Brightness.dark);
        break;
    }
  }

  void updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      _icon = const IconAssetData.dark();
      _image = const ImageAssetData.dark();
    } else {
      _icon = const IconAssetData.light();
      _image = const ImageAssetData.light();
    }

    notifyListeners();
  }
}

extension ResourceManagerExtension on BuildContext {
  ThemeMode get themeMode => ResourceManager.of(this).themeMode;

  IconAssetData get icon => ResourceManager.of(this).icon;

  ImageAssetData get image => ResourceManager.of(this).image;
}
