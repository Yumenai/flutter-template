import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'manager/repository_manager.dart';
import 'manager/resource_manager.dart';
import 'route/splash_route.dart';
import 'service/data_storage_service.dart';
import 'service/info_service.dart';
import 'service/route_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InfoService.initialise();
  await DataStorageService.initialise();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ResourceManager();
          },
        ),
        Provider(
          create: (context) {
            return RepositoryManager();
          },
        ),
      ],
      child: const RootApplication(),
    ),
  );
}

class RootApplication extends StatefulWidget {
  const RootApplication({super.key});

  @override
  State<RootApplication> createState() => _RootApplicationState();
}

class _RootApplicationState extends State<RootApplication> with WidgetsBindingObserver {
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
      navigatorKey: RouteService.instance.key,
      title: 'Flutter Template',
      themeMode: context.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        dividerTheme: const DividerThemeData(
          thickness: 0.15,
          space: 0.05,
          color: Colors.black,
        ),
        tabBarTheme: const TabBarTheme(
          dividerHeight: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        dividerTheme: const DividerThemeData(
          thickness: 0.15,
          space: 0.05,
          color: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          dividerHeight: 0,
        ),
      ),
      home: const SplashRoute().build(context),
      builder: (context, child) {
        return Banner(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          location: BannerLocation.topStart,
          message: 'Dev',
          color: Colors.red,
          child: GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: child,
          ),
        );
      },
    );
  }
}
