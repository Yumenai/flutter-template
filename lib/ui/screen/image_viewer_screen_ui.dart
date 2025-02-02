import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreenUi extends StatelessWidget {
  const ImageViewerScreenUi({
    super.key,
    required this.image,
    this.imageTag,
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;
  final ImageProvider image;
  final String? imageTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleComponent(),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        imageProvider: image,
        heroAttributes: PhotoViewHeroAttributes(
          tag: imageTag ?? UniqueKey().toString(),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
    );
  }

  Widget _titleComponent() {
    final titleComponent =  [
      Text(
        title ?? '',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      if (subtitle?.isNotEmpty ?? false)
        Text(
          subtitle ?? '',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
    ];


    if (titleComponent.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: titleComponent,
      );
    }

    return titleComponent.firstOrNull ?? const SizedBox();
  }
}
