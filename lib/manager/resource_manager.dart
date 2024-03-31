import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/resource/color_resource_data.dart';
import '../data/resource/icon_resource_data.dart';
import '../data/resource/image_resource_data.dart';

class ResourceManager extends ChangeNotifier {
  static ResourceManager initialise() {
    return ResourceManager._();
  }

  static ResourceManager of(final BuildContext context) {
    return Provider.of<ResourceManager>(
      context,
      listen: false,
    );
  }

  static ResourceManager listen(final BuildContext context) {
    return Provider.of<ResourceManager>(context);
  }

  ResourceManager._();

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  ColorResourceData _color = const ColorResourceData.light();
  ColorResourceData get color => _color;

  IconResourceData _icon = const IconResourceData.light();
  IconResourceData get icon => _icon;

  ImageResourceData _image = const ImageResourceData.light();
  ImageResourceData get image => _image;

  void updateTheme(final ThemeMode themeMode) {
    _themeMode = themeMode;

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
      _color = const ColorResourceData.dark();
      _icon = const IconResourceData.dark();
      _image = const ImageResourceData.dark();
    } else {
      _color = const ColorResourceData.light();
      _icon = const IconResourceData.light();
      _image = const ImageResourceData.light();
    }

    notifyListeners();
  }
}
