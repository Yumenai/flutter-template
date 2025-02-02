import 'dart:async';

import 'package:flutter/material.dart';

class TickerComponent extends StatefulWidget {
  const TickerComponent({
    super.key,
    required this.onBuild,
    this.onProcess,
  });

  final bool Function()? onProcess;
  final Widget Function() onBuild;

  @override
  State<TickerComponent> createState() => _TickerComponentState();
}

class _TickerComponentState extends State<TickerComponent> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (widget.onProcess?.call() ?? true && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onBuild();
  }
}
