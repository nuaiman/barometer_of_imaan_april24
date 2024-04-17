import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/gps.dart';
import '../../../models/salah.dart';
import '../../gps/controller/gps_controller.dart';
import '../../reminder/controllers/reminder_controller.dart';

class SalahController extends StateNotifier<List<Salah>> {
  final GpsModel _gpsController;
  final ReminderController _salahNotificationController;
  SalahController(
      {required GpsModel gpsController,
      required ReminderController salahNotificationController})
      : _gpsController = gpsController,
        _salahNotificationController = salahNotificationController,
        super([]);

  Future<void> getPrayerTimes() async {
    final myCoordinates =
        Coordinates(_gpsController.latitude, _gpsController.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    final salahList = [
      Salah(
        id: 0,
        nameEn: 'Sunrise',
        nameBn: 'সূর্যোদয়',
        time: prayerTimes.sunrise,
      ),
      Salah(
        id: 1,
        nameEn: 'Fazr',
        nameBn: 'ফজর',
        time: prayerTimes.fajr,
      ),
      Salah(
        id: 2,
        nameEn: 'Dhuhr',
        nameBn: 'জোহর',
        time: prayerTimes.dhuhr,
      ),
      Salah(
        id: 3,
        nameEn: 'Asr',
        nameBn: 'আসর',
        time: prayerTimes.asr,
      ),
      Salah(
        id: 4,
        nameEn: 'Magrib',
        nameBn: 'মাগরিব',
        time: prayerTimes.maghrib,
      ),
      Salah(
        id: 5,
        nameEn: 'Isha',
        nameBn: 'ইশা',
        time: prayerTimes.isha,
      ),
    ];
    Future.delayed(const Duration(microseconds: 10), () {
      state = salahList;
    });
    await AwesomeNotifications().cancelAll();
    await _salahNotificationController.initializeAlarms(salahList);
  }

  Salah getNextSalah(DateTime now) {
    final salahList = state;
    if (salahList.isEmpty) {
      return Salah(
          id: -1,
          nameEn: 'No Salah',
          nameBn: 'কোন সালাত নেই',
          time: DateTime.now());
    }
    salahList.sort((a, b) => a.time.compareTo(b.time));
    for (int i = 0; i < salahList.length; i++) {
      if (salahList[i].time.isAfter(now)) {
        return salahList[i];
      }
    }
    final nextDay = salahList[0].time.add(const Duration(days: 1));
    Future.delayed(const Duration(microseconds: 1), () {
      state = List.from(state);
    });
    return Salah(
        id: salahList[0].id,
        nameEn: salahList[0].nameEn,
        nameBn: salahList[0].nameBn,
        time: nextDay);
  }

  Duration updateRemainingTime() {
    final now = DateTime.now();
    final nextSalah = getNextSalah(now);
    Future.delayed(const Duration(microseconds: 1), () {
      state = List.from(state);
    });
    return nextSalah.time.difference(now);
  }
}
// -----------------------------------------------------------------------------

final salahProvider =
    StateNotifierProvider<SalahController, List<Salah>>((ref) {
  final gpsController = ref.watch(gpsControllerProvider);
  final notificationController = ref.watch(reminderProvider.notifier);
  return SalahController(
    gpsController: gpsController,
    salahNotificationController: notificationController,
  );
});
