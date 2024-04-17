import '../../../core/constants/pngs.dart';
import '../controllers/last_read_quran_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/widgets/app_bar.dart';
import '../../initialization/controllers/language_controller.dart';
import '../../../models/quran.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahView extends ConsumerStatefulWidget {
  final QuranSurah surah;
  final int verseId;

  static route({required QuranSurah surah, int? verseId}) => MaterialPageRoute(
        builder: (context) => SurahView(
          surah: surah,
          verseId: verseId ?? 0,
        ),
      );

  const SurahView({
    super.key,
    required this.surah,
    this.verseId = 0,
  });

  @override
  SurahScreenState createState() => SurahScreenState();
}

class SurahScreenState extends ConsumerState<SurahView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(_scrollListener);
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final positions = itemPositionsListener.itemPositions.value;
    int lastCrossedIndex = -1;

    for (var position in positions) {
      if (position.itemLeadingEdge < 0.8) {
        if (position.index != 0) {
          lastCrossedIndex = position.index;
        }
      } else {
        break;
      }
    }

    if (lastCrossedIndex != -1) {
      ref
          .read(lastReadQuranProvider.notifier)
          .saveSurahVerseToSharedPreferences(widget.surah.id, lastCrossedIndex);
      // print('Index of the latest item that crossed 0.8: $lastCrossedIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    final isEnglish = ref.watch(languageIsEnglishProvider);
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
              title: !isEnglish
                  ? widget.surah.transliteratioBn
                  : widget.surah.transliterationEn,
              onBackPressed: () {
                ref.read(lastReadQuranProvider.notifier).updateState();
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: ScrollablePositionedList.separated(
                  initialScrollIndex: widget.verseId,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: widget.surah.verses.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 0),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // SvgPicture.asset(Svgs.surahCard),
                              Positioned(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 12, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            !isEnglish
                                                ? widget.surah.transliteratioBn
                                                : widget
                                                    .surah.transliterationEn,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          // Txt(
                                          //   !languageIsEnglish
                                          //       ? widget.surah.transliteratioBn
                                          //       : widget.surah.transliterationEn,
                                          //   color: Palette.white,
                                          //   fontSize: 24,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                          // Txt(
                                          //   widget.surah.name,
                                          //   color: Palette.white,
                                          //   fontSize: 24,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                          Text(
                                            widget.surah.name,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            !isEnglish
                                                ? widget.surah.translationBn
                                                : widget.surah.translationEn,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          // Txt(
                                          //   !languageIsEnglish
                                          //       ? widget.surah.translationBn
                                          //       : widget.surah.translationEn,
                                          //   color: Palette.white,
                                          //   fontSize: 18,
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      const Divider(),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            !isEnglish
                                                ? 'মোট আয়াত: ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(widget.surah.verses.length.toString())}'
                                                : 'Total Verse: ${widget.surah.verses.length}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          // Txt(
                                          //   !languageIsEnglish
                                          //       ? 'মোট আয়াত: ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(widget.surah.verses.length.toString())}'
                                          //       : 'Total Verse: ${widget.surah.verses.length}',
                                          //   color: Palette.white,
                                          //   fontSize: 18,
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      final verse = widget.surah.verses[index - 1];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // SvgPicture.asset(
                                        //   Svgs.counterFill,
                                        // ),
                                        Text(
                                          !isEnglish
                                              ? ref
                                                  .read(
                                                      languageIsEnglishProvider
                                                          .notifier)
                                                  .convertEnglishToBangla(
                                                      verse.id.toString())
                                              : verse.id.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        // Txt(
                                        //   !languageIsEnglish
                                        //       ? ref
                                        //           .read(
                                        //               languageIsEnglishProvider
                                        //                   .notifier)
                                        //           .convertEnglishToBangla(
                                        //               verse.id.toString())
                                        //       : verse.id.toString(),
                                        //   color: Palette.white,
                                        //   fontSize: 14,
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        verse.text,
                                        textDirection: TextDirection.rtl,
                                        style: const TextStyle(
                                          fontSize: 32,
                                        ),
                                      ),
                                      // Txt(
                                      //   verse.text,
                                      //   fontSize: 22,
                                      //   color: Palette.green,
                                      //   textDirection: TextDirection.rtl,
                                      // ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          !isEnglish
                                              ? verse.transliterationBn
                                              : verse.transliterationEn,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // Txt(
                                        //   !languageIsEnglish
                                        //       ? verse.transliterationBn
                                        //       : verse.transliterationEn,
                                        //   fontSize: 20,
                                        //   fontWeight: FontWeight.w500,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        !isEnglish
                                            ? verse.translationBn
                                            : verse.translationEn,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Txt(
                                      //   !languageIsEnglish
                                      //       ? verse.translationBn
                                      //       : verse.translationEn,
                                      //   fontSize: 16,
                                      // ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
