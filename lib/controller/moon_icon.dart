import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class MoonIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const MoonIcon({super.key, this.size = 20.0, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/moon.svg', width: size, height: size);
  }
}
