import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../deeds/controllers/deeds_controller.dart';
import '../../gps/controller/gps_controller.dart';
import '../../home/view/home_view.dart';
import '../../quran/controllers/last_read_quran_controller.dart';
import '../../quran/controllers/quran_controller.dart';
import '../../reminder/controllers/reminder_controller.dart';
import 'internet_conntection_checker.dart';

class InitializationController extends StateNotifier<bool> {
  final QuranController _quranController;
  final DeedsController _deedsController;
  final LastreadQuranController _lastreadQuranController;
  final ReminderController _salahNotificationController;
  final GpsController _gpsController;
  // final SalahController _salahController;
  final InternetConnectionController _internetConnectionController;
  InitializationController({
    required QuranController quranController,
    required DeedsController deedsController,
    required LastreadQuranController lastreadQuranController,
    required ReminderController salahNotificationController,
    required GpsController gpsController,
    // required SalahController salahController,
    required InternetConnectionController internetConnectionController,
  })  : _quranController = quranController,
        _deedsController = deedsController,
        _lastreadQuranController = lastreadQuranController,
        _salahNotificationController = salahNotificationController,
        _gpsController = gpsController,
        // _salahController = salahController,
        _internetConnectionController = internetConnectionController,
        super(false);

  Future<void> initialize(BuildContext context) async {
    if (context.mounted) {
      await _quranController.loadQuranSurahs(context);
    }
    await _lastreadQuranController.getSurahFromSharedPreferences();
    await _deedsController.loadDeeds();
    await _salahNotificationController.loadSalahAlarms();

    // final hasInternet =
    await _internetConnectionController.checkInternetConnection();

    if (context.mounted) {
      await _gpsController.checkPermissionAndFetchOnlyLatLong(context);
      // if (hasInternet) {
      //   await _gpsController.checkPermissionAndFetchLocation(context);
      // } else {
      //   await _gpsController.checkPermissionAndFetchOnlyLatLong(context);
      // }
    }

    if (context.mounted) {
      Navigator.of(context)
          .pushAndRemoveUntil(HomeView.route(), (route) => false);
    }
  }
}
// -----------------------------------------------------------------------------

final initializationProvider =
    StateNotifierProvider<InitializationController, bool>((ref) {
  final quranController = ref.watch(quranProvider.notifier);
  final deedsController = ref.watch(deedsProvider.notifier);
  final lastreadQuranController = ref.watch(lastReadQuranProvider.notifier);
  final salahNotificationController = ref.watch(reminderProvider.notifier);
  final gpsController = ref.watch(gpsControllerProvider.notifier);
  // final salahController = ref.watch(salahProvider.notifier);
  final internetConnectionController =
      ref.watch(internetConnectionProvider.notifier);
  return InitializationController(
    quranController: quranController,
    deedsController: deedsController,
    lastreadQuranController: lastreadQuranController,
    salahNotificationController: salahNotificationController,
    gpsController: gpsController,
    // salahController: salahController,
    internetConnectionController: internetConnectionController,
  );
});
