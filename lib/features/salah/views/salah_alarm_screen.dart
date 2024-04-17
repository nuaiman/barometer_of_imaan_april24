import 'package:barometer_of_imaan/features/initialization/controllers/language_controller.dart';
import 'package:barometer_of_imaan/features/salah/controllers/salah_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/widgets/app_bar.dart';
import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../models/salah.dart';
import '../../../models/salah_alarm.dart';
import '../../reminder/controllers/reminder_controller.dart';

class SalahAlarmScreen extends ConsumerWidget {
  final Salah salah;
  static route(Salah salah) => MaterialPageRoute(
        builder: (context) => SalahAlarmScreen(
          salah: salah,
        ),
      );
  const SalahAlarmScreen({
    super.key,
    required this.salah,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(salahProvider);
    SalahAlarm? salahNotif =
        ref.read(reminderProvider.notifier).getSalahAlarmById(salah.id);
    final languageIsEnglish = ref.watch(languageIsEnglishProvider);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Pngs.arabicBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                  title: !languageIsEnglish ? salah.nameBn : salah.nameEn),
              Expanded(
                child: Card(
                  color: Palette.liteGrey,
                  surfaceTintColor: Palette.liteGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () {
                          ref
                              .read(reminderProvider.notifier)
                              .removeSalahAlarm(salah.id, salah);
                        },
                        leading: const CircleAvatar(
                          backgroundColor: Palette.liteGrey,
                          foregroundColor: Palette.green,
                          radius: 25,
                          child: Icon(CupertinoIcons.bell_slash),
                        ),
                        title: Text(
                          !languageIsEnglish ? 'বন্ধ' : 'Disabled',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          !languageIsEnglish
                              ? 'বিজ্ঞপ্তি বন্ধ'
                              : 'You won\'t be notified',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Palette.grey,
                          ),
                        ),
                        trailing: salahNotif == null
                            ? const Icon(
                                Icons.check,
                                color: Palette.green,
                              )
                            : const Icon(null),
                      ),
                      const Divider(
                        color: Palette.grey,
                        thickness: 0.5,
                        indent: 80,
                        endIndent: 15,
                      ),
                      // --------------------------------
                      ListTile(
                        onTap: () {
                          ref.read(reminderProvider.notifier).addSalahAlarm(
                                SalahAlarm(
                                  id: salah.id,
                                  titleEn: salah.nameEn,
                                  isAzan: false,
                                  date: salah.time,
                                ),
                                salah,
                              );
                        },
                        // ignore: prefer_const_constructors
                        leading: CircleAvatar(
                          backgroundColor: Palette.liteGrey,
                          foregroundColor: Palette.green,
                          radius: 25,
                          child: const Icon(
                            CupertinoIcons.bell,
                            color: Palette.green,
                          ),
                        ),
                        title: Text(
                          !languageIsEnglish ? 'চালু' : 'Enabled',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          !languageIsEnglish
                              ? 'সতর্কতা দেওয়া হবে'
                              : 'You will be alerted',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Palette.grey,
                          ),
                        ),
                        trailing: salahNotif != null
                            ? const Icon(
                                Icons.check,
                                color: Palette.green,
                              )
                            : const Icon(null),
                      ),
                      const Divider(
                        color: Palette.grey,
                        thickness: 0.5,
                        indent: 80,
                        endIndent: 15,
                      ),
                      // --------------------------------
                      ListTile(
                        onTap: () async {
                          ref.read(reminderProvider.notifier).addSalahAlarm(
                                SalahAlarm(
                                  id: salah.id,
                                  titleEn: salah.nameEn,
                                  isAzan: false,
                                  date: salah.time,
                                ),
                                salah,
                              );

                          ref
                              .read(reminderProvider.notifier)
                              .toggleSalahAzanStatus(salah.id, salah);
                        },
                        leading: CircleAvatar(
                          backgroundColor:
                              (salahNotif != null && salahNotif.isAzan)
                                  ? Palette.green
                                  : Palette.liteGrey,
                          foregroundColor: Palette.green,
                          radius: 25,
                          child: Icon(
                            CupertinoIcons.bell,
                            color: (salahNotif != null && salahNotif.isAzan)
                                ? Palette.liteGrey
                                : Palette.green,
                          ),
                        ),
                        title: Text(
                          !languageIsEnglish ? 'আজান' : 'Azan',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          !languageIsEnglish
                              ? 'আজান দেওয়া হবে'
                              : 'Azan will be given',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Palette.grey,
                          ),
                        ),
                      ),
                    ],
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
