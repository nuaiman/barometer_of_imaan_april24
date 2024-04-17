import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/salah.dart';
import '../../../models/salah_alarm.dart';

class ReminderController extends StateNotifier<List<SalahAlarm>> {
  ReminderController() : super([]) {
    loadSalahAlarms();
  }

  static const _key = 'salahAlarm';

  Future<void> loadSalahAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final Map<int, SalahAlarm> uniqueSalahAlarms = {};
      for (var item in jsonList) {
        final SalahAlarm salahAlarm = SalahAlarm.fromMap(item);
        if (!uniqueSalahAlarms.containsKey(salahAlarm.id)) {
          uniqueSalahAlarms[salahAlarm.id] = salahAlarm;
        }
      }
      final List<SalahAlarm> loadedAlarms = uniqueSalahAlarms.values.toList();
      state = loadedAlarms;
    }
  }

  Future<void> _saveSalahAlarms(List<SalahAlarm> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        alarms.map((alarm) => alarm.toMap()).toList();
    prefs.setString(_key, json.encode(jsonList));
    state = List.from(state);
  }

  Future<void> addSalahAlarm(SalahAlarm salahAlarm, Salah salah) async {
    final List<SalahAlarm> existingAlarms = state;
    final existingIndex =
        existingAlarms.indexWhere((alarm) => alarm.id == salahAlarm.id);
    if (existingIndex != -1) {
      existingAlarms[existingIndex] = salahAlarm;
    } else {
      existingAlarms.add(salahAlarm);
    }
    await _saveSalahAlarms(existingAlarms);
    state = existingAlarms;
    await setAlarmForSalah(salah, salahAlarm);
    state = List.from(state);
  }

  Future<void> removeSalahAlarm(int id, Salah salah) async {
    final List<SalahAlarm> existingAlarms = state;
    final existingIndex = existingAlarms.indexWhere((alarm) => alarm.id == id);
    if (existingIndex != -1) {
      existingAlarms.removeAt(existingIndex);
      await _saveSalahAlarms(existingAlarms);
      state = existingAlarms;
      await AwesomeNotifications().cancel(salah.id);
      state = List.from(state);
    }
  }

  Future<void> toggleSalahAzanStatus(int id, Salah salah) async {
    final List<SalahAlarm> existingAlarms = state;
    final existingIndex = existingAlarms.indexWhere((alarm) => alarm.id == id);
    if (existingIndex != -1) {
      final updatedAlarm = existingAlarms[existingIndex].copyWith(
        isAzan: !existingAlarms[existingIndex].isAzan, // Toggle isAzan value
      );
      existingAlarms[existingIndex] = updatedAlarm;
      await _saveSalahAlarms(existingAlarms);
      state = existingAlarms;
      await setAlarmForSalah(salah, updatedAlarm);
      state = List.from(state);
    }
  }

  SalahAlarm? getSalahAlarmById(int id) {
    final itemIndex = state.indexWhere((element) => element.id == id);
    if (itemIndex == -1) {
      return null;
    }
    return state.firstWhere(
      (alarm) => alarm.id == id,
    );
  }

  Future<void> setAlarmForSalah(Salah salah, SalahAlarm salahAlarm) async {
    await AwesomeNotifications().cancel(salah.id);
    await AwesomeNotifications().cancel(salah.id * 10);
    final notificationId = salahAlarm.isAzan ? salah.id * 10 : salah.id;
    final scheduledTime = salah.time;
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    // -----------------------
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: notificationId.toString(),
        title: salah.id == 0 ? 'Reminder' : 'Prayer Reminder',
        body: salah.id == 0
            ? 'The sun is rising'
            : 'It\'s time for ${salah.nameEn} prayer.',
        category: NotificationCategory.Reminder,
        actionType: ActionType.DismissAction,
      ),
      schedule: NotificationCalendar(
        repeats: true,
        preciseAlarm: true,
        timeZone: localTimeZone,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
        second: scheduledTime.second,
        allowWhileIdle: true,
      ),
    );
  }

  Future<void> initializeAlarms(List<Salah> salahList) async {
    for (final salah in salahList) {
      final existingAlarm = getSalahAlarmById(salah.id);
      if (existingAlarm != null) {
        await setAlarmForSalah(salah, existingAlarm);
      }
    }
  }
}
// -----------------------------------------------------------------------------

final reminderProvider =
    StateNotifierProvider<ReminderController, List<SalahAlarm>>((ref) {
  return ReminderController();
});
