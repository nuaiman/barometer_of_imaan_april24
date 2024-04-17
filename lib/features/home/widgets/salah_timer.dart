import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/palette.dart';
import '../../../models/salah_alarm.dart';
import '../../initialization/controllers/language_controller.dart';
import '../../reminder/controllers/reminder_controller.dart';
import '../../salah/controllers/salah_controller.dart';
import '../../salah/views/salah_alarm_screen.dart';

class SalahTimer extends ConsumerWidget {
  const SalahTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    ref.watch(salahProvider);
    // ref.watch(salahNotificationProvider);
    final nextSalah =
        ref.watch(salahProvider.notifier).getNextSalah(DateTime.now());
    SalahAlarm? salahNotif =
        ref.read(reminderProvider.notifier).getSalahAlarmById(nextSalah.id);
    Duration remainingTime =
        ref.watch(salahProvider.notifier).updateRemainingTime();
    // SalahAlarm? salahNotif = ref
    //     .read(salahNotificationProvider.notifier)
    //     .getSalahAlarmById(nextSalah.id);
    final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Container(
        height: 191,
        decoration: BoxDecoration(
          color: Palette.liteGrey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Container(
              height: 68,
              decoration: BoxDecoration(
                color: Palette.green,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      !languageIsEnglish
                          ? 'পরবর্তী সালাত ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(remainingTime.inHours.toString())}:${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla((remainingTime.inMinutes.remainder(60)).toString().padLeft(2, '0'))}:${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla((remainingTime.inSeconds.remainder(60)).toString().padLeft(2, '0'))}'
                          : 'Next Prayer in ${remainingTime.inHours}:${(remainingTime.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(remainingTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(SalahAlarmScreen.route(nextSalah));
                      },
                      child: salahNotif == null
                          ? Icon(
                              CupertinoIcons.bell_slash,
                              color: Palette.white,
                            )
                          : Icon(
                              CupertinoIcons.bell,
                              color: Palette.white,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  !languageIsEnglish
                      ? '${nextSalah.nameBn} ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(DateFormat.jm().format(nextSalah.time)).replaceAll('AM', 'এ.ম').replaceAll('PM', 'প.ম')}'
                      : '${nextSalah.nameEn} ${DateFormat.jm().format(nextSalah.time)}',
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
