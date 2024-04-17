import 'package:barometer_of_imaan/features/qibla/view/qibla_view.dart';
import 'package:barometer_of_imaan/features/salah/views/salah_view.dart';

import '../../deeds/views/deeds_view.dart';
import 'tile_of_grid.dart';
import '../../quran/views/quran_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/svgs.dart';
import '../../initialization/controllers/language_controller.dart';

class Grid extends ConsumerWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(DeedsView.route());
                  },
                  child: TileOfGrid(
                    title: !isEnglish ? 'করণীয়' : 'Deeds',
                    svgPath: Svgs.deeds,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(SalahView.route());
                  },
                  child: TileOfGrid(
                    title: !isEnglish ? 'সালাহ' : 'Salah',
                    svgPath: Svgs.salah,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(QiblaView.route());
                  },
                  child: TileOfGrid(
                    title: !isEnglish ? 'কিবলা' : 'Qibla',
                    svgPath: Svgs.qibla,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(QuranView.route());
                  },
                  child: TileOfGrid(
                    title: !isEnglish ? 'আল-কোরআন' : 'Al-Quran',
                    svgPath: Svgs.quran,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
