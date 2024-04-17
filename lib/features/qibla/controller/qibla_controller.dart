import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QiblaController extends StateNotifier<AsyncValue<QiblahDirection>> {
  QiblaController() : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    final deviceSupport = await FlutterQiblah.androidDeviceSensorSupport();
    if (deviceSupport != null) {
      try {
        final stream = FlutterQiblah.qiblahStream;
        stream.listen((qiblahDirection) {
          state = AsyncValue.data(qiblahDirection);
        });
      } catch (e) {
        state =
            AsyncValue.error(e.toString(), StackTrace.fromString(e.toString()));
      }
    } else {
      state = AsyncValue.error(
        'Device does not support Qibla direction',
        StackTrace.current,
      );
    }
  }
}

// -----------------------------------------------------------------------------
final qiblaControllerProvider =
    StateNotifierProvider<QiblaController, AsyncValue<QiblahDirection>>(
        (ref) => QiblaController());
