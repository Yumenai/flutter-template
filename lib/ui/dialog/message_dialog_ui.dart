import 'package:flutter/material.dart';

class MessageDialogUi {
  const MessageDialogUi({
    required this.message,
    this.duration = const Duration(
      seconds: 1,
      milliseconds: 500,
    ),
  });

  const MessageDialogUi.comingSoon()
      : message = 'Coming Soon',
        duration = const Duration(
          seconds: 1,
          milliseconds: 500,
        );

  final String? message;
  final Duration duration;

  Future<void> show(final BuildContext context) async {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(message ?? ''),
        duration: duration,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        // margin: const EdgeInsets.all(24),
        behavior: SnackBarBehavior.floating,
      ),
    );

    await Future.delayed(duration);
  }
}
