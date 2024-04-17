import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/pngs.dart';
import '../../../core/constants/svgs.dart';
import '../../deeds/controllers/daily_deeds_controller.dart';
import '../../deeds/controllers/deeds_controller.dart';
import '../../initialization/controllers/language_controller.dart';

class Meter extends ConsumerWidget {
  const Meter({
    super.key,
  });

  double calculatePercentageDeedsDone(
      int totalAvailableDeedsLength, int completedDeedsLength) {
    if (completedDeedsLength == 0) {
      return 0.0;
    }
    return (completedDeedsLength / totalAvailableDeedsLength) * 100;
  }

  String getStatus(bool isEnglish, double percentage) {
    if (percentage <= 0) {
      return '';
    } else if (percentage <= 15) {
      return !isEnglish ? 'অবস্থা: গড়ের নিচে' : 'Status: Below Avegare';
    } else if (percentage <= 25) {
      return !isEnglish ? 'অবস্থা: ফাইন' : 'Status: Avegare';
    } else if (percentage <= 50) {
      return !isEnglish ? 'অবস্থা: ভাল' : 'Status: Good';
    } else if (percentage <= 75) {
      return !isEnglish ? 'অবস্থা: খুব ভালো' : 'Status: Very Good';
    } else if (percentage <= 99) {
      return !isEnglish ? 'অবস্থা: অসাধারণ' : 'Status: Awesome';
    } else {
      return !isEnglish ? 'অবস্থা: চমৎকার' : 'Status: Excellent';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    ref.watch(deedsProvider);
    final dailyDeeds = ref.read(dailyDeedsProvider);
    final completedDeeds =
        ref.watch(deedsProvider.notifier).getDeedsForToday(DateTime.now());
    int totalAvailableDeedsLength = dailyDeeds.length;
    double percentage = calculatePercentageDeedsDone(
        totalAvailableDeedsLength, completedDeeds.length);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: AssetImage(Pngs.geometryBg), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  !isEnglish
                      ? 'আজ ${ref.read(languageIsEnglishProvider.notifier).convertEnglishToBangla(DateFormat('dd MMMM, yyyy').format(DateTime.now())).replaceAll('January', 'জানুয়ারি').replaceAll('February', 'ফেব্রুয়ারি').replaceAll('March', 'মার্চ').replaceAll('April', 'এপ্রিল').replaceAll('May', 'মে').replaceAll('June', 'জুন').replaceAll('July', 'জুলাই').replaceAll('August', 'অগাস্ট').replaceAll('September', 'সেপ্টেম্বর').replaceAll('October', 'অক্টোবর').replaceAll('November', 'নভেম্বর').replaceAll('December', 'ডিসেম্বর')}'
                      : 'Today ${DateFormat('dd MMMM, yyyy').format(DateTime.now())}',
                  style: const TextStyle(
                    color: Colors.white,
                    // fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(Svgs.barometerChart),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 6)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 5)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 4)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 3)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 2)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 1)),
                      ),
                      MeterBar(
                        date: DateTime.now().subtract(const Duration(days: 0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  !isEnglish
                      ? getStatus(false, percentage)
                      : getStatus(true, percentage),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MeterBar extends ConsumerWidget {
  final DateTime date;
  const MeterBar({
    super.key,
    required this.date,
  });

  double calculatePercentageDeedsDone(
      int totalAvailableDeedsLength, int completedDeedsLength) {
    if (completedDeedsLength == 0) {
      return 0.0;
    }
    return (completedDeedsLength / totalAvailableDeedsLength) * 100;
  }

  Color getBarColor(double percentage) {
    if (percentage == 0) {
      return Colors.transparent;
    } else if (percentage <= 25) {
      return Colors.red;
    } else if (percentage <= 50) {
      return Colors.orange;
    } else if (percentage <= 75) {
      return Colors.greenAccent;
    } else if (percentage <= 99) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnglish = ref.watch(languageIsEnglishProvider);
    final dailyDeeds = ref.read(dailyDeedsProvider);

    final completedDeeds =
        ref.watch(deedsProvider.notifier).getDeedsForToday(date);
    int totalAvailableDeedsLength = dailyDeeds.length;
    double percentage = calculatePercentageDeedsDone(
        totalAvailableDeedsLength, completedDeeds.length);
    double barMaxHeight = 130;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: SizedBox(
        width: 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: barMaxHeight,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                ),
                Container(
                  height: completedDeeds.isEmpty
                      ? 0
                      : (barMaxHeight * percentage / 100)
                          .clamp(0, barMaxHeight),
                  width: 10,
                  decoration: BoxDecoration(
                    color: getBarColor(percentage),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              isEnglish
                  ? DateFormat('EEEE').format(date).substring(0, 3)
                  : DateFormat('EEEE')
                      .format(date)
                      .replaceAll('Monday', 'সোম')
                      .replaceAll('Tuesday', 'মঙ্গল')
                      .replaceAll('Wednesday', 'বুধ')
                      .replaceAll('Thursday', 'বৃহঃ')
                      .replaceAll('Friday', 'শুক্র')
                      .replaceAll('Saturday', 'শনি')
                      .replaceAll('Sunday', 'রবি'),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
