import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({Key? key, required this.child, this.width, this.height}) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: const BorderRadius.only(
            topRight: radiusSmall,
            bottomLeft: radiusSmall,
          ),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(child: child),
      ),
    );
  }
}
