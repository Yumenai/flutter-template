import 'package:flutter/material.dart';

import '../component/button/icon_button_component_ui.dart';

class DashboardScreenUi extends StatelessWidget {
  const DashboardScreenUi({
    super.key,
    required this.onLogout,
  });

  final void Function(BuildContext) onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButtonComponentUi(
            icon: Icon(Icons.exit_to_app),
            hint: 'Logout',
            foregroundColor: Theme.of(context).colorScheme.error,
            onTap: () => onLogout(context),
          ),
        ],
      ),
    );
  }
}
