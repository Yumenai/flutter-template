import 'package:flutter/material.dart';

import '../../data/animation_data.dart';
import '../../manager/resource_manager.dart';
import '../../service/info_service.dart';

class AppAvatarWidget extends StatelessWidget {
  const AppAvatarWidget({
    super.key,
    this.title = '',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrientationBuilder(
          builder: (context, _) {
            final media = MediaQuery.of(context);
            final double dimensionSize;

            if (media.orientation == Orientation.portrait) {
              dimensionSize = media.size.width / 2;
            } else {
              dimensionSize = media.size.height / 2;
            }

            return Hero(
              tag: AnimationData.tag.appLogo,
              child: SizedBox.square(
                dimension: dimensionSize,
                child: Image.asset(
                  context.image.appLogoTransparent,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          title.isEmpty ? InfoService.instance.appName : title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
