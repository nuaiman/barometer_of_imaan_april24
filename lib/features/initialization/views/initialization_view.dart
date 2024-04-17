import 'package:barometer_of_imaan/core/constants/pngs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/initialization_controller.dart';

class InitializationView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const InitializationView(),
      );
  const InitializationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(initializationProvider.notifier).initialize(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Pngs.arabicBg),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
