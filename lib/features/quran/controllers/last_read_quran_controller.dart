import 'quran_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/quran.dart';

class LastreadQuranController extends StateNotifier<SavedSurahVerse?> {
  final QuranController _quranController;
  LastreadQuranController({required QuranController quranController})
      : _quranController = quranController,
        super(null);

  static const String surahIdKey = 'surahId';
  static const String verseIdKey = 'verseId';

  void saveSurahVerseToSharedPreferences(int surahId, int verseId) {
    _saveSurahVerseToSharedPreferences(surahId, verseId);
  }

  Future<void> _saveSurahVerseToSharedPreferences(
      int surahId, int verseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(surahIdKey, surahId);
    prefs.setInt(verseIdKey, verseId);
    final surah = _quranController.getSurahById(surahId);
    state = SavedSurahVerse(surah: surah!, verseId: verseId);
  }

  Future<SavedSurahVerse?> getSurahFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? surahId = prefs.getInt(surahIdKey);
    int? verseId = prefs.getInt(verseIdKey);
    if (surahId != null && verseId != null) {
      QuranSurah? surah = _quranController.getSurahById(surahId);
      if (surah != null) {
        final gottenSura = _quranController.getSurahById(surahId);
        state = SavedSurahVerse(surah: gottenSura!, verseId: verseId);
        return SavedSurahVerse(surah: surah, verseId: verseId);
      }
    }
    return null;
  }

  void updateState() {
    final newState = state;
    state = newState;
  }
}
// -----------------------------------------------------------------------------

final lastReadQuranProvider =
    StateNotifierProvider<LastreadQuranController, SavedSurahVerse?>((ref) {
  final quranController = ref.watch(quranProvider.notifier);
  return LastreadQuranController(quranController: quranController);
});
