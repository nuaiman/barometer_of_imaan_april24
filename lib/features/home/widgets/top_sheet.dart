import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class DummyModal extends StatelessWidget {
  const DummyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.green,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SvgPicture.asset(Svgs.close),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
