import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/quran.dart';

class QuranController extends StateNotifier<List<QuranSurah>> {
  QuranController() : super([]);

  Future<void> loadQuranSurahs(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/quran.json');
    List<dynamic> surahsJson = json.decode(data);
    state = surahsJson.map((json) => QuranSurah.fromJson(json)).toList();
  }

  QuranSurah? getSurahById(int id) {
    return state.firstWhere((surah) => surah.id == id);
  }
}

// -----------------------------------------------------------------------------
final quranProvider =
    StateNotifierProvider<QuranController, List<QuranSurah>>((ref) {
  return QuranController();
});
