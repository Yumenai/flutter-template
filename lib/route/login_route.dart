import 'package:flutter/material.dart';

import '../service/route_service.dart';
import '../ui/dialog/message_dialog_ui.dart';
import '../ui/screen/landing_screen_ui.dart';
import '../ui/screen/login_screen_ui.dart';
import '../ui/screen/pin_verification_screen_ui.dart';
import 'splash_route.dart';

class LoginRoute {
  const LoginRoute();

  void start() {
    LandingScreenUi(
      onSignInWithEmail: _loginEmail,
      onSignInWithPhone: _loginPhone,
      onSignInWithApple: _loginApple,
      onSignInWithGoogle: _loginGoogle,
      onSignInWithFacebook: _loginFacebook,
    ).startScreen();
  }

  void _loginEmail(final BuildContext context) {
    LoginScreenUi.email(
      onLogin: (context, email) {
        RouteService.instance.nextScreen((context) {
          return PinVerificationScreenUi(
            title: 'Verify Email Address',
            sentTo: email,
            onVerify: _verifyPin,
            onRequest: (context) {
              MessageDialogUi.comingSoon().show(context);
            },
          );
        });
      },
    ).nextScreen();
  }

  void _loginPhone(final BuildContext context) {
    LoginScreenUi.phone(
      onLogin: (context, phoneNumber, phoneCode) {
        RouteService.instance.nextScreen((context) {
          return PinVerificationScreenUi(
            title: 'Verify Mobile Number',
            sentTo: '($phoneCode) $phoneNumber',
            onVerify: _verifyPin,
            onRequest: (context) {
              MessageDialogUi.comingSoon().show(context);
            },
          );
        });
      },
      onUpdatePhoneCode: (context) async {
        return null;
      },
    ).nextScreen();
  }

  void _loginApple(final BuildContext context) {
    MessageDialogUi.comingSoon().show(context);
  }

  void _loginGoogle(final BuildContext context) {
    MessageDialogUi.comingSoon().show(context);
  }

  void _loginFacebook(final BuildContext context) {
    MessageDialogUi.comingSoon().show(context);
  }

  Future<bool> _verifyPin(final BuildContext context, final String pin) async {
    MessageDialogUi.comingSoon().show(context);

    SplashRoute().start();
    return true;
  }
}
