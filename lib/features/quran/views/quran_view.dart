import '../../../core/constants/pngs.dart';
import '../controllers/last_read_quran_controller.dart';
import 'surah_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../models/quran.dart';
import '../../initialization/controllers/language_controller.dart';
import '../controllers/quran_controller.dart';

class QuranView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const QuranView(),
      );
  const QuranView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quran = ref.watch(quranProvider);
    SavedSurahVerse? gottenSurah = ref.watch(lastReadQuranProvider);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              CustomAppBar(
                title: !isEnglish ? 'আল-কোরআন' : 'Al-Quran',
              ),
              gottenSurah == null
                  ? const SizedBox.shrink()
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        // SvgPicture.asset(Svgs.surahCard),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 18, top: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Txt(
                                    //   !languageIsEnglish
                                    //       ? 'শেষ পড়া'
                                    //       : 'Last Read',
                                    //   color: Palette.lime,
                                    //   fontSize: 14,
                                    // ),
                                    Text(
                                      !isEnglish ? 'শেষ পড়া' : 'Last Read',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      !isEnglish
                                          ? gottenSurah.surah.transliteratioBn
                                          : gottenSurah.surah.transliterationEn,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // Txt(
                                    //   !languageIsEnglish
                                    //       ? gottenSurah.surah.transliteratioBn
                                    //       : gottenSurah.surah.transliterationEn,
                                    //   color: Palette.white,
                                    //   fontSize: 24,
                                    //   fontWeight: FontWeight.w500,
                                    // ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(SurahView.route(
                                          surah: gottenSurah.surah,
                                          verseId: gottenSurah.verseId,
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Txt(
                                    //   !languageIsEnglish
                                    //       ? 'আয়াত: ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(gottenSurah.verseId.toString())}'
                                    //       : 'Verse: ${gottenSurah.verseId}',
                                    //   color: Palette.white,
                                    //   fontSize: 18,
                                    // ),
                                    Text(
                                      !isEnglish
                                          ? 'আয়াত: ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(gottenSurah.verseId.toString())}'
                                          : 'Verse: ${gottenSurah.verseId}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              Expanded(
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: quran.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final surah = quran[index];
                    return Container(
                      decoration: BoxDecoration(
                        // color: Palette.liteGrey,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  SurahView.route(surah: surah),
                                );
                              },
                              leading: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // SvgPicture.asset(Svgs.counterStroke),
                                  // Txt(
                                  //   !languageIsEnglish
                                  //       ? ref
                                  //           .read(languageIsEnglishProvider
                                  //               .notifier)
                                  //           .convertEnglishToBangla(
                                  //               (index + 1).toString())
                                  //       : (index + 1).toString(),
                                  //   fontSize: 20,
                                  //   color: Palette.green,
                                  // ),
                                  Text(
                                    !isEnglish
                                        ? ref
                                            .read(languageIsEnglishProvider
                                                .notifier)
                                            .convertEnglishToBangla(
                                                (index + 1).toString())
                                        : (index + 1).toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              title: Text(
                                !isEnglish
                                    ? surah.transliteratioBn
                                    : surah.transliterationEn,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //  Txt(
                              //   !languageIsEnglish
                              //       ? surah.transliteratioBn
                              //       : surah.transliterationEn,
                              //   fontSize: 24,
                              //   fontWeight: FontWeight.w600,
                              // ),
                              subtitle: Text(
                                !isEnglish
                                    ? surah.translationBn
                                    : surah.translationEn,
                                style: const TextStyle(fontSize: 18),
                              ),

                              // Txt(
                              //   !languageIsEnglish
                              //       ? surah.translationBn
                              //       : surah.translationEn,
                              //   fontSize: 18,
                              //   color: Palette.grey,
                              // ),
                              trailing: Text(
                                surah.name,
                                style: const TextStyle(fontSize: 24),
                              ),

                              // Txt(
                              //   surah.name,
                              //   fontSize: 24,
                              // ),
                            ),
                            // Positioned(
                            //   top: 0,
                            //   right: 0,
                            //   child: SvgPicture.asset(Svgs.cornerDecorTopRight),
                            // ),
                            // Positioned(
                            //   bottom: 0,
                            //   left: 0,
                            //   child: SvgPicture.asset(Svgs.cornerDecorBottomLeft),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
