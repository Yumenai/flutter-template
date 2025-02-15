import 'package:flutter/material.dart';

import 'setting_screen_ui.dart';

class DashboardScreenUi extends StatefulWidget {
  const DashboardScreenUi({
    super.key,
    required this.settingScreenModelUi,
  });

  final SettingScreenModelUi settingScreenModelUi;

  @override
  State<DashboardScreenUi> createState() => _DashboardScreenUiState();
}

class _DashboardScreenUiState extends State<DashboardScreenUi> {
  var _indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indexPage,
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
          ),
          SettingScreenUi(
            model: widget.settingScreenModelUi,
          ),
        ],
      ),
      bottomNavigationBar: _navigatorComponent(),
    );
  }

  Widget _navigatorComponent() {
    return NavigationBar(
      onDestinationSelected: _moveTo,
      selectedIndex: _indexPage,
      destinations: const <Widget>[
        NavigationDestination(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
        ),
        NavigationDestination(
          label: 'Account',
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
        ),
      ],
    );
  }

  void _moveTo(final int index) {
    setState(() {
      _indexPage = index;
    });
  }
}
