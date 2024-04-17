import 'dart:math';

import 'package:barometer_of_imaan/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/constants/pngs.dart';
import '../../initialization/controllers/language_controller.dart';
import '../../qibla/controller/qibla_controller.dart';

class QiblaView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const QiblaView(),
      );
  const QiblaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomAppBar(
                  title: !isEnglish ? 'কিবলা' : 'Qibla',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SizedBox(
                    height: 300,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final asyncValue = ref.watch(qiblaControllerProvider);
                        return asyncValue.when(
                          loading: () => Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                Svgs.compass,
                                height: 300,
                              ),
                              SvgPicture.asset(
                                Svgs.needle,
                                height: 205,
                              ),
                            ],
                          ),
                          error: (error, stackTrace) => Center(
                            child: Text("Error: $error"),
                          ),
                          data: (qiblahDirection) {
                            final northDirection = qiblahDirection.direction;
                            final qiblaDirection = qiblahDirection.qiblah % 360;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.rotate(
                                  angle: (-northDirection * pi / 180),
                                  child: SvgPicture.asset(
                                    Svgs.compass,
                                    height: 300,
                                  ),
                                ),
                                Transform.rotate(
                                  angle: (-qiblaDirection * pi / 180),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    Svgs.needle,
                                    height: 205,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Consumer(
                    builder: (context, ref, _) {
                      final asyncValue = ref.watch(qiblaControllerProvider);
                      return asyncValue.when(
                        loading: () => Center(
                          child: Text(
                            !isEnglish
                                ? 'ক্যালিব্রেটিং কম্পাস'
                                : 'Calibrating Compass',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.orange),
                          ),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text("Error: $error"),
                        ),
                        data: (qiblahDirection) {
                          final northDirection = qiblahDirection.direction;
                          final qiblaDirection = qiblahDirection.qiblah % 360;
                          return Column(
                            children: [
                              Text(
                                !isEnglish
                                    ? 'কিবলা°${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(qiblaDirection.toStringAsFixed(0))}'
                                    : 'Qibla °${qiblaDirection.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(!isEnglish
                                  ? '${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(northDirection.toStringAsFixed(0))}°ন'
                                  : '${northDirection.toStringAsFixed(0)}° N'),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
