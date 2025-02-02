import 'package:flutter/material.dart';

import '../manager/repository_manager.dart';
import '../service/route_service.dart';
import '../ui/screen/dashboard_screen_ui.dart';
import 'splash_route.dart';

class DashboardRoute {
  const DashboardRoute();

  void start() {
    DashboardScreenUi(
      onLogout: logout,
    ).startScreen();
  }

  void logout(final BuildContext context) {
    context.repository.configuration.clearSession();

    SplashRoute().start();
  }
}
