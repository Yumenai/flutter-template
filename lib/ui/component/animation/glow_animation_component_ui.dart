import 'package:flutter/material.dart';

class GlowAnimationComponentUi extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final BorderRadius borderRadius;

  const GlowAnimationComponentUi({
    super.key,
    required this.child,
    this.glowColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  State<GlowAnimationComponentUi> createState() =>
      _GlowAnimationComponentUiState();
}

class _GlowAnimationComponentUiState extends State<GlowAnimationComponentUi>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // Makes the glow pulsate

    _animation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = widget.glowColor ??Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, final child) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: _animation.value,
                  spreadRadius: _animation.value / 10,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
