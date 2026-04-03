import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/translation_service.dart';

/// الحالة = كود اللغة فقط (`en` / `ar`).
class LocaleCubit extends Cubit<String> {
  LocaleCubit([super.initialState = 'en']);

  final Map<String, String> _cache = {};

  String get languageCode => state;
  bool get isArabic => state == 'ar';

  String tn(String en, String ar) => state == 'en' ? en : ar;

  Future<void> setLanguage(String code) async {
    if (state == code) return;
    _cache.clear();
    emit(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', code);
  }

  Future<String> translate(String text) async {
    if (state == 'en' || text.isEmpty) return text;
    if (_cache.containsKey(text)) return _cache[text]!;

    final translated = await TranslationService.translate(text, state);
    _cache[text] = translated;
    return translated;
  }

  static Future<LocaleCubit> create() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('app_language') ?? 'en';
    return LocaleCubit(lang);
  }
}
