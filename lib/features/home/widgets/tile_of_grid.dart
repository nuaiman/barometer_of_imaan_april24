import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TileOfGrid extends StatelessWidget {
  final String title;
  final String svgPath;
  const TileOfGrid({
    super.key,
    required this.title,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(child: SvgPicture.asset(svgPath)),
        Text(title),
      ],
    );
  }
}
