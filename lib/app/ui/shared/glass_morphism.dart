import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({
    super.key,
    required this.child,
    required this.blur,
    required this.opacity,
    required this.color,
    this.borderRadius = BorderRadius.zero,
  });
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            // borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
