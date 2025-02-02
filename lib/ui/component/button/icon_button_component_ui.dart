import 'package:flutter/material.dart';

enum IconButtonStyle {
  basic,
  outlined,
  elevated,
}

enum IconButtonShape {
  circle,
  square,
}

class ImageButtonSize {
  static const small = Size(40, 40);
  static const large = Size(54, 54);
}

class IconButtonComponentUi extends StatelessWidget {
  const IconButtonComponentUi({
    super.key,
    required this.icon,
    required this.hint,
    required this.onTap,
    this.foregroundColor,
    this.backgroundColor,
    this.size = ImageButtonSize.large,
    this.shape = IconButtonShape.circle,
    this.style = IconButtonStyle.basic,
  });

  final Widget icon;
  final String hint;
  final Size size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final void Function() onTap;

  final IconButtonStyle style;
  final IconButtonShape shape;

  OutlinedBorder _buildShape({
    final Color? borderColor,
  }) {
    final BorderSide borderSide;

    if (borderColor == null) {
      borderSide = BorderSide.none;
    } else {
      borderSide = BorderSide(
        color: borderColor,
        width: 1.5,
     );
    }

    switch(shape) {
      case IconButtonShape.circle:
        return OvalBorder(
          side: borderSide,
        );
      case IconButtonShape.square:
        return RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: borderSide,
        );
    }
  }

  Widget _buildIcon(final BuildContext context) {
    return IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
        size: 24,
        color: foregroundColor,
      ),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget component;

    switch(style) {
      case IconButtonStyle.basic:
        component = TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            minimumSize: size,
            padding: EdgeInsets.zero,
            shape: _buildShape(),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          ),
          child: _buildIcon(context),
        );
      case IconButtonStyle.outlined:
        component = TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            minimumSize: size,
            padding: EdgeInsets.zero,
            shape: _buildShape(
              borderColor: Theme.of(context).colorScheme.primary,
            ),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          ),
          child: _buildIcon(context),
        );
      case IconButtonStyle.elevated:
        component = ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            minimumSize: size,
            padding: EdgeInsets.zero,
            shape: _buildShape(),
          ),
          child: _buildIcon(context),
        );
    }

    return SizedBox.fromSize(
      size: size,
      child: FittedBox(
        child: Tooltip(
          message: hint,
          child: component,
        ),
      ),
    );
  }
}
