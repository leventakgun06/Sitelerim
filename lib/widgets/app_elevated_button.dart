import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Responsive resp = Responsive.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorWhite.withOpacity(.7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: radiusSmall,
            bottomLeft: radiusSmall,
          ),
          side: BorderSide(color: colorBlack, width: 1.2),
        ),
      ),
      child: SizedBox(
        width: resp.wp(40),
        height: resp.hp(8),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
