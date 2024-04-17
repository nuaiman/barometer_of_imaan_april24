import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/constants/pngs.dart';
import '../../initialization/controllers/language_controller.dart';
import '../controllers/daily_deeds_controller.dart';
import '../controllers/deeds_controller.dart';
import '../widgets/deed_tile.dart';

class DeedsView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const DeedsView(),
      );
  const DeedsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    final dailyDeeds = ref.read(dailyDeedsProvider);
    ref.watch(deedsProvider);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Pngs.arabicBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: !isEnglish ? 'করণীয়' : 'Deeds',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dailyDeeds.length,
                itemBuilder: (context, index) {
                  final deed = dailyDeeds[index];
                  return DeedTile(deed: deed);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
