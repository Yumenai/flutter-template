import 'package:flutter/material.dart';

import '../manager/repository_manager.dart';
import '../service/route_service.dart';
import '../ui/dialog/message_dialog_ui.dart';
import '../ui/screen/dashboard_screen_ui.dart';
import '../ui/screen/setting_screen_ui.dart';
import 'splash_route.dart';

class DashboardRoute {
  const DashboardRoute();

  void start() {
    DashboardScreenUi(
      settingScreenModelUi: SettingScreenModelUi(
        onTapProfile: MessageDialogUi.comingSoon().show,
        onTapNotification: MessageDialogUi.comingSoon().show,
        onTapLanguage: MessageDialogUi.comingSoon().show,
        onTapTheme: MessageDialogUi.comingSoon().show,
        onTapAuthenticator: MessageDialogUi.comingSoon().show,
        onTapSupportFeedback: MessageDialogUi.comingSoon().show,
        onTapLogout: logout,
        onTapDelete: MessageDialogUi.comingSoon().show,
      ),
    ).startScreen();
  }

  void logout(final BuildContext context) {
    context.repository.configuration.clearSession();

    SplashRoute().start();
  }
}
