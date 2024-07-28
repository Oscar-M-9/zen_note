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
    // this.margin,
    // this.padding,
  });
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final BorderRadius borderRadius;
  // final EdgeInsetsGeometry? margin;
  // final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          // margin: margin,
          // padding: padding,
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
