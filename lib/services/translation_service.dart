import 'package:translator/translator.dart';

class TranslationService {
  static final GoogleTranslator _translator = GoogleTranslator();

  /// Translates [text] from English to [targetLang] using the official-like Google Translate engine.
  static Future<String> translate(String text, String targetLang) async {
    if (text.isEmpty) return text;
    try {
      final translation = await _translator.translate(
        text,
        from: 'en',
        to: targetLang,
      );
      return translation.text;
    } catch (e) {
      print("Google Translation Error: $e");
      // Fallback to original text if fails
      return text;
    }
  }
}
