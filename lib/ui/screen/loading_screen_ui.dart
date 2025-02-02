import 'package:flutter/material.dart';

import '../widget/app_avatar_widget.dart';

class LoadingScreenUi extends StatefulWidget {
  const LoadingScreenUi({
    super.key,
    required this.onInitialise,
  });

  final void Function(BuildContext) onInitialise;

  @override
  State<LoadingScreenUi> createState() => _LoadingScreenUiState();
}

class _LoadingScreenUiState extends State<LoadingScreenUi> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onInitialise(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const [
            AppAvatarWidget(),
            SizedBox(
              height: 24,
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
