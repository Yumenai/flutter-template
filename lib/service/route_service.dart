import 'package:flutter/material.dart';

class RouteService {
  static RouteService instance = RouteService._();

  final key = GlobalKey<NavigatorState>();

  RouteService._();

  NavigatorState? get _navigatorState => key.currentState;

  Future<T?> startScreen<T>(final WidgetBuilder onBuild) async {
    final result = await key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: onBuild),
      (_) => false,
    );

    if (result is T) return result;

    return null;
  }

  Future<T?> nextScreen<T>(final WidgetBuilder onBuild) async {
    final result = await _navigatorState?.push(MaterialPageRoute(
      builder: onBuild,
    ));

    if (result is T) return result;

    return null;
  }

  Future<T?> replaceScreen<T>(final WidgetBuilder onBuild) async {
    final result = await key.currentState?.pushReplacement(
      MaterialPageRoute(builder: onBuild),
    );

    if (result is T) return result;

    return null;
  }

  Future<T?> showPopupDialog<T>(
    final WidgetBuilder onBuild, {
    final bool canDismiss = true,
  }) async {
    final context = key.currentState?.context;

    if (context == null) return null;

    final result = await showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: onBuild,
    );

    if (result is T) return result;

    return null;
  }
}

extension RouteServiceExtension on Widget {
  Future<T?> startScreen<T>() {
    return RouteService.instance.startScreen<T>((context) {
      return this;
    });
  }

  Future<T?> nextScreen<T>() {
    return RouteService.instance.nextScreen<T>((context) {
      return this;
    });
  }

  Future<T?> replaceScreen<T>() {
    return RouteService.instance.startScreen<T>((context) {
      return this;
    });
  }

  Future<T?> showPopupDialog<T>() {
    return RouteService.instance.showPopupDialog<T>((context) {
      return this;
    });
  }
}
