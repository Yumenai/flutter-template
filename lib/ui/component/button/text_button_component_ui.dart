import 'package:flutter/material.dart';

enum TextButtonStyle {
  basic,
  outlined,
  elevated,
}

enum TextButtonShape {
  rectangularCurved,
  rectangularRounded,
}

class TextButtonComponentUi extends StatelessWidget {
  const TextButtonComponentUi({
    super.key,
    required this.text,
    required this.onTap,
    this.leading,
    this.trailing,
    this.canExpand = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    this.foregroundColor,
    this.backgroundColor,
    this.shape = TextButtonShape.rectangularRounded,
    this.style = TextButtonStyle.basic,
  });

  const TextButtonComponentUi.submit({
    super.key,
    required this.text,
    required this.onTap,
    this.leading,
    this.trailing,
    this.shape = TextButtonShape.rectangularRounded,
    this.style = TextButtonStyle.elevated,
  }) :  canExpand = true,
        padding = const EdgeInsets.all(14),
        foregroundColor = null,
        backgroundColor = null;

  final Widget text;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets padding;
  final bool canExpand;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final void Function() onTap;

  final TextButtonStyle style;
  final TextButtonShape shape;

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
      case TextButtonShape.rectangularCurved:
        return StadiumBorder(
          side: borderSide,
        );
      case TextButtonShape.rectangularRounded:
        return RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          side: borderSide,
        );
    }
  }

  Widget _buildContent() {
    if (leading == null && trailing == null) {
      return text;
    }

    return Row(
      children: [
        SizedBox.square(
          dimension: 24,
          child: leading,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DefaultTextStyle(
            style: TextStyle(
              color: foregroundColor,
            ),
            textAlign: TextAlign.center,
            child: text,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox.square(
          dimension: 24,
          child: trailing,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget component;

    switch(style) {
      case TextButtonStyle.basic:
        component = TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: padding,
            shape: _buildShape(),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          ),
          child: _buildContent(),
        );
      case TextButtonStyle.outlined:
        component = TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: padding,
            shape: _buildShape(
              borderColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          child: _buildContent(),
        );
      case TextButtonStyle.elevated:
        component = ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            padding: padding,
            shape: _buildShape(),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: _buildContent(),
        );
    }

    if (canExpand) {
      return SizedBox(
        width: double.infinity,
        child: component,
      );
    }

    return component;
  }
}
