import 'package:barometer_of_imaan/features/salah/views/salah_alarm_screen.dart';
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
      child: GestureDetector(
        onTap: salah.id == 0
            ? () {}
            : () {
                Navigator.of(context).push(SalahAlarmScreen.route(salah));
              },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        salah.id == 0
                            ? null
                            : salahNotif == null
                                ? CupertinoIcons.bell_slash
                                : CupertinoIcons.bell,
                        color: Colors.black,
                      ),
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
      ),
    );
  }
}
