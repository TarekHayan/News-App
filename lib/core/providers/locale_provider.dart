import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/translation_service.dart';

class LocaleProvider extends ChangeNotifier {
  String _languageCode;

  /// In-memory cache: original English text → translated text
  final Map<String, String> _cache = {};

  LocaleProvider({String initialLang = 'en'}) : _languageCode = initialLang;

  // ──────────────────────────── Getters ────────────────────────────

  String get languageCode => _languageCode;
  Locale get locale => Locale(_languageCode);
  bool get isArabic => _languageCode == 'ar';

  // ──────────────────────────── Language switching ────────────────────────────

  /// Changes the active language, persists it, and rebuilds all listening widgets.
  Future<void> setLanguage(String code) async {
    if (_languageCode == code) return;
    _languageCode = code;
    _cache.clear(); // old translations belong to the previous language
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', code);
  }

  // ──────────────────────────── Translation ────────────────────────────

  /// Returns the translated version of [text].
  /// - Returns [text] immediately when the language is English.
  /// - Returns a cached result instantly if already translated.
  /// - Otherwise calls the MyMemory API and caches the result.
  Future<String> translate(String text) async {
    if (_languageCode == 'en' || text.isEmpty) return text;
    if (_cache.containsKey(text)) return _cache[text]!;

    final translated = await TranslationService.translate(text, _languageCode);
    _cache[text] = translated;
    return translated;
  }

  // ──────────────────────────── Factory ────────────────────────────

  /// Loads the persisted language from SharedPreferences.
  static Future<LocaleProvider> create() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('app_language') ?? 'en';
    return LocaleProvider(initialLang: lang);
  }
}
