import 'package:flutter/material.dart';

import '../service/route_service.dart';
import '../ui/screen/loading_screen_ui.dart';

class SplashRoute {
  const SplashRoute();

  void start() {
    RouteService.instance.startScreen(build);
  }

  Widget build(final BuildContext context) {
    return LoadingScreenUi(
      onInitialise: (context) async {
        await Future.delayed(const Duration(seconds: 2));

        // To Something
      },
    );
  }
}
