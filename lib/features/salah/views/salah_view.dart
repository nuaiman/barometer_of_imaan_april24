import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/common/widgets/app_bar.dart';
import '../../../core/constants/pngs.dart';
import '../../initialization/controllers/language_controller.dart';
import '../controllers/salah_controller.dart';
import '../widgets/salah_time_tile.dart';

class SalahView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SalahView(),
      );
  const SalahView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salah = ref.watch(salahProvider);
    final nextSalah =
        ref.watch(salahProvider.notifier).getNextSalah(DateTime.now());
    Duration remainingTime =
        ref.watch(salahProvider.notifier).updateRemainingTime();
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
          child: Column(
            children: [
              CustomAppBar(
                title: !isEnglish ? 'সালাহ' : 'Salah',
              ),
              ListTile(
                title: Text(!isEnglish ? nextSalah.nameBn : nextSalah.nameEn),
                subtitle: Text(!isEnglish
                    ? ref
                        .read(languageIsEnglishProvider.notifier)
                        .convertEnglishToBangla(
                            DateFormat.jm().format(nextSalah.time))
                        .replaceAll('AM', 'এ.ম')
                        .replaceAll('PM', 'প.ম')
                    : DateFormat.jm().format(nextSalah.time)),
                trailing: Text(!isEnglish
                    ? '${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla((remainingTime.inHours.remainder(60)).toString().padLeft(2, '0'))}:${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla((remainingTime.inMinutes.remainder(60)).toString().padLeft(2, '0'))}:${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla((remainingTime.inSeconds.remainder(60)).toString().padLeft(2, '0'))}'
                    : '${remainingTime.inHours}:${(remainingTime.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(remainingTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}'),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SalahTimeTile(
                    salah: salah[0],
                  ),
                  const SizedBox(width: 5),
                  SalahTimeTile(
                    salah: salah[1],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SalahTimeTile(
                    salah: salah[2],
                  ),
                  const SizedBox(width: 5),
                  SalahTimeTile(
                    salah: salah[3],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SalahTimeTile(
                    salah: salah[4],
                  ),
                  const SizedBox(width: 5),
                  SalahTimeTile(
                    salah: salah[5],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
