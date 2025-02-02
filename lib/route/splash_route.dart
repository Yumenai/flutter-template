import 'package:flutter/material.dart';

import '../manager/repository_manager.dart';
import '../service/route_service.dart';
import '../ui/screen/loading_screen_ui.dart';
import 'dashboard_route.dart';
import 'login_route.dart';

class SplashRoute {
  const SplashRoute();

  void start() {
    RouteService.instance.startScreen(build);
  }

  Widget build(final BuildContext context) {
    return LoadingScreenUi(
      onInitialise: (context) async {
        await Future.delayed(const Duration(seconds: 2));

        if (!context.mounted) return;

        if (context.repository.configuration.hasAccessToken) {
          DashboardRoute().start();
        } else {
          LoginRoute().start();
        }
      },
    );
  }
}
