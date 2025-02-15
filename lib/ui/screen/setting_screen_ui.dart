import 'package:flutter/material.dart';

import '../../manager/resource_manager.dart';

class SettingScreenUi extends StatelessWidget {
  const SettingScreenUi({
    super.key,
    required this.model,
  });

  final SettingScreenModelUi model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          _ItemList(
            title: 'Profile',
            icon: Icon(Icons.person_outline),
            onTap: () => model.onTapProfile(context),
          ),
          _CategoryList('Preference'),
          _ItemList(
            title: 'Notification',
            icon: Icon(Icons.notifications_outlined),
            onTap: () => model.onTapNotification(context),
          ),
          _ItemList(
            title: 'Language',
            subtitle: 'English',
            icon: Icon(Icons.language),
            onTap: () => model.onTapLanguage(context),
          ),
          _ItemList(
            title: 'Theme',
            subtitle: 'Light',
            icon: Icon(Icons.brightness_5_outlined),
            onTap: () => model.onTapTheme(context),
          ),
          _CategoryList('Account'),
          _ItemList(
            title: 'Authenticator',
            icon: Icon(Icons.lock_outline),
            onTap: () => model.onTapAuthenticator(context),
          ),
          _ItemList(
            title: 'Support & Feedback',
            icon: Icon(Icons.info_outline),
            onTap: () => model.onTapSupportFeedback(context),
          ),
          _ItemList(
            title: 'Logout',
            icon: Icon(Icons.exit_to_app),
            color: context.color.negative,
            onTap: () => model.onTapLogout(context),
          ),
          _ItemList(
            title: 'Delete',
            icon: Icon(Icons.delete_outline),
            color: context.color.negative,
            onTap: () => model.onTapDelete(context),
          ),
        ],
      ),
    );
  }
}

class SettingScreenModelUi {
  const SettingScreenModelUi({
    required this.onTapProfile,
    required this.onTapNotification,
    required this.onTapLanguage,
    required this.onTapTheme,
    required this.onTapAuthenticator,
    required this.onTapSupportFeedback,
    required this.onTapLogout,
    required this.onTapDelete,
  });

  final void Function(BuildContext) onTapProfile;
  final void Function(BuildContext) onTapNotification;
  final void Function(BuildContext) onTapLanguage;
  final void Function(BuildContext) onTapTheme;
  final void Function(BuildContext) onTapAuthenticator;
  final void Function(BuildContext) onTapSupportFeedback;
  final void Function(BuildContext) onTapLogout;
  final void Function(BuildContext) onTapDelete;
}

class _CategoryList extends StatelessWidget {
  const _CategoryList(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
            bottom: 4,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.color,
  });

  final String? title;
  final String? subtitle;
  final Widget icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title ?? '',
        style: TextStyle(
          color: color,
        ),
      ),
      subtitle: _subtitleComponent,
      leading: IconTheme(
        data: IconThemeData(
          color: color,
        ),
        child: icon,
      ),
      onTap: onTap,
    );
  }

  Widget? get _subtitleComponent {
    if (subtitle?.isEmpty ?? true) {
      return null;
    }

    return Text(
      subtitle ?? '',
      style: TextStyle(
        color: color,
      ),
    );
  }
}
