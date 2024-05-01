import 'package:barometer_of_imaan/core/common/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/constants/svgs.dart';
import '../../initialization/controllers/language_controller.dart';

class SettingsScreen extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      );
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Pngs.arabicBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: ''),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage(Pngs.greenBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  !languageIsEnglish
                                      ? 'বারোমিটার অফ ইমান'
                                      : 'Barometer of I’maan',
                                  style: const TextStyle(
                                    color: Palette.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .push(NotificationSettingsScreen.route());
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 60,
                                  child:
                                      Center(child: Icon(CupertinoIcons.bell)),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  !languageIsEnglish
                                      ? 'নোটিফিকেশন'
                                      : 'Notification',
                                  style: const TextStyle(
                                    color: Palette.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 12),
                            child: Divider(color: Palette.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .push(LanguageSettingsScreen.route());
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 60,
                                  child:
                                      Center(child: Icon(CupertinoIcons.globe)),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  !languageIsEnglish ? 'ভাষা' : 'Language',
                                  style: const TextStyle(
                                    color: Palette.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 12),
                            child: Divider(color: Palette.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context)
                              //     .push(HistorySettingsScreen.route());
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 60,
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.doc_chart,
                                      color: Palette.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  !languageIsEnglish ? 'ইতিহাস' : 'History',
                                  style: const TextStyle(
                                    color: Palette.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
