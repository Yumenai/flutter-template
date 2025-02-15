import 'package:flutter/material.dart';

import '../../manager/resource_manager.dart';
import '../component/button/text_button_component_ui.dart';
import '../component/svg_component_ui.dart';
import '../widget/app_avatar_widget.dart';

class LandingScreenUi extends StatelessWidget {
  const LandingScreenUi({
    super.key,
    required this.onSignInWithEmail,
    required this.onSignInWithPhone,
    required this.onSignInWithApple,
    required this.onSignInWithGoogle,
    required this.onSignInWithFacebook,
  });

  final void Function(BuildContext) onSignInWithEmail;
  final void Function(BuildContext) onSignInWithPhone;
  final void Function(BuildContext) onSignInWithApple;
  final void Function(BuildContext) onSignInWithGoogle;
  final void Function(BuildContext) onSignInWithFacebook;

  Widget _portraitScreen() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const AppAvatarWidget(),
          const SizedBox(
            height: 48,
          ),
          _ActionWidget(
            onSignInWithEmail: onSignInWithEmail,
            onSignInWithPhone: onSignInWithPhone,
            onSignInWithApple: onSignInWithApple,
            onSignInWithGoogle: onSignInWithGoogle,
            onSignInWithFacebook: onSignInWithFacebook,
          ),
        ],
      ),
    );
  }

  Widget _landscapeScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: AppAvatarWidget(
                  title: 'Login',
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: _ActionWidget(
                  onSignInWithEmail: onSignInWithEmail,
                  onSignInWithPhone: onSignInWithPhone,
                  onSignInWithApple: onSignInWithApple,
                  onSignInWithGoogle: onSignInWithGoogle,
                  onSignInWithFacebook: onSignInWithFacebook,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          switch (orientation) {
            case Orientation.portrait:
              return _portraitScreen();
            case Orientation.landscape:
              return _landscapeScreen();
          }
        },
      ),
    );
  }
}

class _ActionWidget extends StatelessWidget {
  const _ActionWidget({
    required this.onSignInWithEmail,
    required this.onSignInWithPhone,
    required this.onSignInWithApple,
    required this.onSignInWithGoogle,
    required this.onSignInWithFacebook,
  });

  final void Function(BuildContext) onSignInWithEmail;
  final void Function(BuildContext) onSignInWithPhone;
  final void Function(BuildContext) onSignInWithApple;
  final void Function(BuildContext) onSignInWithGoogle;
  final void Function(BuildContext) onSignInWithFacebook;

  Widget _buttonComponent({
    required final String text,
    required final Widget icon,
    required final VoidCallback onTap,
    final Color? foregroundColor,
    final Color? backgroundColor,
  }) {
    return TextButtonComponentUi(
      text: Text(text),
      leading: icon,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      style: TextButtonStyle.elevated,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buttonComponent(
          text: 'Sign in with Email',
          icon: Icon(
            Icons.email_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onTap: () => onSignInWithEmail(context),
        ),
        const SizedBox(height: 12),
        _buttonComponent(
          text: 'Sign in with Mobile',
          icon: Icon(
            Icons.call_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onTap: () => onSignInWithPhone(context),
        ),
        const SizedBox(height: 12),
        _buttonComponent(
          text: 'Sign in with Google',
          icon: SvgComponentUi.asset(context.icon.google),
          foregroundColor: context.color.onGoogle,
          backgroundColor: context.color.google,
          onTap: () => onSignInWithGoogle(context),
        ),
        const SizedBox(height: 12),
        _buttonComponent(
          text: 'Sign in with Facebook',
          icon: SvgComponentUi.asset(context.icon.facebook),
          foregroundColor: context.color.onFacebook,
          backgroundColor: context.color.facebook,
          onTap: () => onSignInWithFacebook(context),
        ),
        const SizedBox(height: 12),
        _buttonComponent(
          text: 'Sign in with Apple',
          icon: SvgComponentUi.asset(context.icon.apple),
          foregroundColor: context.color.onApple,
          backgroundColor: context.color.apple,
          onTap: () => onSignInWithApple(context),
        ),
      ],
    );
  }
}
