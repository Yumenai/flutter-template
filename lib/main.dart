import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/resource/color_resource_data.dart';
import 'manager/resource_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ResourceManager.initialise();
          },
        ),
      ],
      child: RootTemplate(
        title: 'Flutter Template',
        rootRoute: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Template'),
          ),
        ),
        themeLight: ThemeData(
          colorScheme: const ColorResourceData.light(),
          useMaterial3: true,
        ),
        themeDark: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          colorScheme: const ColorResourceData.dark(),
        ),
      ),
    ),
  );
}

class RootTemplate extends StatefulWidget {
  final String title;
  final Widget rootRoute;
  final ThemeData themeDark;
  final ThemeData themeLight;

  const RootTemplate({
    super.key,
    required this.title,
    required this.rootRoute,
    required this.themeDark,
    required this.themeLight,
  });

  @override
  State<RootTemplate> createState() => _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      if (ResourceManager.of(context).themeMode == ThemeMode.system) {
        ResourceManager.of(context).updateBrightness(
          WidgetsBinding.instance.platformDispatcher.platformBrightness,
        );
      } else {
        ResourceManager.of(context).updateBrightness(
          Theme.of(context).brightness,
        );
      }
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      themeMode: ResourceManager.listen(context).themeMode,
      theme: widget.themeLight,
      darkTheme: widget.themeDark,
      home: widget.rootRoute,
    );
  }
}
