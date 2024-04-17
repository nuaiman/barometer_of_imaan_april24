import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/salah.dart';
import '../../../models/salah_alarm.dart';
import '../../initialization/controllers/language_controller.dart';
import '../../reminder/controllers/reminder_controller.dart';

class SalahTimeTile extends ConsumerWidget {
  final Salah salah;
  const SalahTimeTile({
    super.key,
    required this.salah,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reminderProvider);
    SalahAlarm? salahNotif =
        ref.read(reminderProvider.notifier).getSalahAlarmById(salah.id);
    final isEnglish = ref.watch(languageIsEnglishProvider);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(reminderProvider.notifier).toggleSalahAlarm(
                          SalahAlarm(
                              id: salah.id,
                              titleEn: salah.nameEn,
                              date: salah.time),
                          salah);
                    },
                    icon: salahNotif != null
                        ? const Icon(
                            CupertinoIcons.bell,
                            color: Colors.green,
                          )
                        : const Icon(
                            CupertinoIcons.bell_slash,
                            color: Colors.orange,
                          ),

                    // SvgPicture.asset(
                    //   salahNotif != null
                    //       ? Svgs.notificationBlack
                    //       : Svgs.notificationOff,
                    //   colorFilter: ColorFilter.mode(
                    //     salahNotif != null ? Palette.white : Palette.black,
                    //     BlendMode.srcIn,
                    //   ),
                    // ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                !isEnglish ? salah.nameBn : salah.nameEn,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // Txt(
              //   !languageIsEnglish ? salah.nameBn : salah.nameEn,
              //   fontSize: 28,
              //   fontWeight: FontWeight.w700,
              //   color: salahNotif != null ? Palette.white : Palette.black,
              // ),
              Text(
                !isEnglish
                    ? ref
                        .read(languageIsEnglishProvider.notifier)
                        .convertEnglishToBangla(
                            DateFormat.jm().format(salah.time))
                        .replaceAll('AM', 'এ.ম')
                        .replaceAll('PM', 'প.ম')
                    : DateFormat.jm().format(salah.time),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Txt(
              //   !languageIsEnglish
              //       ? ref
              //           .read(languageIsEnglishProvider.notifier)
              //           .convertEnglishToBangla(
              //               DateFormat.jm().format(salah.time))
              //           .replaceAll('AM', 'এ.ম')
              //           .replaceAll('PM', 'প.ম')
              //       : DateFormat.jm().format(salah.time),
              //   fontSize: 22,
              //   fontWeight: FontWeight.w500,
              //   color: salahNotif != null ? Palette.white : Palette.black,
              // ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
