import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPictureAsset extends StatelessWidget {
  const CustomSvgPictureAsset({
    super.key,
    required this.path,
    this.width,
    this.height,
  }) : _isColorFilter = false,
       color = Colors.transparent;

  const CustomSvgPictureAsset.withColorFilter({
    super.key,
    required this.path,
    required this.color,
    this.width,
    this.height,
  }) : _isColorFilter = true;

  final String path;
  final bool _isColorFilter;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: (_isColorFilter)
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }
}
