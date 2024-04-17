import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectionController extends StateNotifier<bool> {
  InternetConnectionController() : super(false) {
    checkInternetConnection();
  }

  Future<bool> checkInternetConnection() async {
    final initialStatus = await InternetConnection().hasInternetAccess;
    state = initialStatus;
    return state;
  }
}

// -----------------------------------------------------------------------------

final internetConnectionProvider =
    StateNotifierProvider<InternetConnectionController, bool>((ref) {
  return InternetConnectionController();
});
