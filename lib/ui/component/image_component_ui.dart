import 'package:flutter/material.dart';

// This image component will fade in image when loaded successfully
class ImageComponentUi extends StatelessWidget {
  final ImageProvider image;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlend;

  const ImageComponentUi({
    super.key,
    required this.image,
    this.errorPlaceholder,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  });

  Widget _errorPlaceholder(final BuildContext context) {
    if (errorPlaceholder is Widget) {
      return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 250)),
        builder: (context, asyncSnapshot) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: asyncSnapshot.connectionState == ConnectionState.done ? 1 : 0,
            child: errorPlaceholder ?? const Placeholder(),
          );
        },
      );
    } else {
      /// Put default empty image placeholder
      if (Theme.of(context).brightness == Brightness.dark) {
        return Container(
          color: const Color(0xFF424242),
        );
      } else {
        return Container(
          color: const Color(0xFFEEEEEE),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: fit,
      image: image,
      color: color,
      colorBlendMode: colorBlend,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        // Assuming only network image require loading animation
        if (image is NetworkImage) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(
                milliseconds: 250,
              ),
              child: child,
            );
          }
        } else {
          return child;
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return _errorPlaceholder(context);
      },
    );
  }
}
