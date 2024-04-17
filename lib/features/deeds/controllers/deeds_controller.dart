import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/deed.dart';

class DeedsController extends StateNotifier<List<Deed>> {
  DeedsController() : super([]);

  static const _key = 'deeds';

  // Future<void> loadDeeds() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String>? deedsJson = prefs.getStringList(_key);

  //   if (deedsJson != null) {
  //     List<Deed> deeds =
  //         deedsJson.map((json) => Deed.fromJson(jsonDecode(json))).toList();
  //     state = deeds;
  //   } else {
  //     state = [];
  //   }
  // }

  Future<void> loadDeeds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? deedsJson = prefs.getStringList(_key);
    if (deedsJson != null) {
      List<Deed> deeds =
          deedsJson.map((json) => Deed.fromJson(jsonDecode(json))).toList();
      DateTime currentTime = DateTime.now();
      deeds = deeds.where((deed) {
        DateTime deedTime = DateTime(deed.year, deed.month, deed.day);
        return currentTime.difference(deedTime).inDays <= 7;
      }).toList();

      state = deeds;
    } else {
      state = [];
    }
  }

  Future<void> _saveDeeds(List<Deed> deeds) async {
    final prefs = await SharedPreferences.getInstance();
    final deedsJson = deeds.map((deed) => jsonEncode(deed.toJson())).toList();
    await prefs.setStringList(_key, deedsJson);
  }

  void markAsDone(Deed deed, bool value) {
    final updateAbleDeed = deed.copyWith(isDone: value);
    bool isSameDeed(Deed existingDeed) {
      return existingDeed.id == deed.id &&
          existingDeed.dayOfWeek == deed.dayOfWeek &&
          existingDeed.day == deed.day &&
          existingDeed.month == deed.month &&
          existingDeed.year == deed.year;
    }

    if (value == true) {
      final alreadyExists = state.any(isSameDeed);
      if (!alreadyExists) {
        state = [...state, updateAbleDeed];
      }
    } else {
      state.removeWhere(isSameDeed);
      state = List.from(state);
    }
    _saveDeeds(state);
  }

  bool getIsDoneStatus(Deed deed) {
    try {
      return state
          .firstWhere((element) =>
              element.id == deed.id &&
              element.dayOfWeek == deed.dayOfWeek &&
              element.day == deed.day &&
              element.month == deed.month &&
              element.year == deed.year)
          .isDone;
    } catch (e) {
      return false;
    }
  }

  bool getIsDoneStatusById(int id) {
    try {
      return state.firstWhere((deed) => deed.id == id).isDone;
    } catch (e) {
      return false;
    }
  }

  bool getIsDoneStatusByIdAndDate(int id) {
    try {
      return state
          .firstWhere(
            (deed) =>
                deed.id == id &&
                deed.day == DateTime.now().day &&
                deed.month == DateTime.now().month &&
                deed.year == DateTime.now().year,
          )
          .isDone;
    } catch (e) {
      return false;
    }
  }

  Map<String, List<Deed>> getLast7DaysDeeds() {
    final today = DateTime.now();
    final last7Days =
        List.generate(7, (index) => today.subtract(Duration(days: index)));
    Map<String, List<Deed>> result = {};
    for (int i = 0; i < last7Days.length; i++) {
      String dayKey;
      if (i == 0) {
        dayKey = "Today";
      } else if (i == 1) {
        dayKey = "1DayAgo";
      } else {
        dayKey = "${i}DaysAgo";
      }
      List<Deed> deedsForDay = state.where((deed) {
        return deed.year == last7Days[i].year &&
            deed.month == last7Days[i].month &&
            deed.day == last7Days[i].day;
      }).toList();
      result[dayKey] = deedsForDay;
    }
    return result;
  }

  List<Deed> getDeedsForToday(DateTime date) {
    return state.where((deed) {
      return deed.year == date.year &&
          deed.month == date.month &&
          deed.day == date.day;
    }).toList();
  }
}

// -----------------------------------------------------------------------------

final deedsProvider = StateNotifierProvider<DeedsController, List<Deed>>((ref) {
  return DeedsController();
});
