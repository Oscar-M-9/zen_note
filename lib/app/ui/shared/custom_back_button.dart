import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.maybePop();
      },
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SvgPicture.asset(
          "assets/svg/back.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).appBarTheme.iconTheme?.color,
        ),
      ),
    );
  }
}
