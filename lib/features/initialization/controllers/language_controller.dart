import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends StateNotifier<bool> {
  LanguageController() : super(true) {
    loadLanguage();
  }

  static const _key = 'language';

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      state = prefs.getBool(_key)!;
    } else {
      state = true;
    }
  }

  Future<void> toggleLanguage(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
    state = value;
  }

  String convertEnglishToBangla(String englishNumber) {
    final Map<String, String> banglaDigits = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    String banglaNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      String digit = englishNumber[i];
      if (banglaDigits.containsKey(digit)) {
        banglaNumber += banglaDigits[digit]!;
      } else {
        banglaNumber += digit;
      }
    }
    return banglaNumber;
  }
}
// -----------------------------------------------------------------------------

final languageIsEnglishProvider =
    StateNotifierProvider<LanguageController, bool>((ref) {
  return LanguageController();
});
