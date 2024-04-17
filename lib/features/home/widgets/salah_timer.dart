import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/salah_alarm.dart';
import '../../initialization/controllers/language_controller.dart';
import '../../reminder/controllers/reminder_controller.dart';
import '../../salah/controllers/salah_controller.dart';

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
    // final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          // image: const DecorationImage(
          //     image: AssetImage(Pngs.arabicBg), fit: BoxFit.cover),
        ),
        child: ListTile(
          leading: salahNotif != null
              ? const Icon(
                  CupertinoIcons.bell,
                  color: Colors.green,
                )
              : const Icon(
                  CupertinoIcons.bell_slash,
                  color: Colors.orange,
                ),
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

        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Last Read'),
        //           Text('Verse : 6'),
        //         ],
        //       ),
        //       SizedBox(height: 6),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text('Al- Fatiha'),
        //           Icon(CupertinoIcons.arrow_right),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
