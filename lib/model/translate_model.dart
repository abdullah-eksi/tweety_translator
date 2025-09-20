import 'dart:convert';
import '../service/aiService.dart';

class TranslationResult {
  final String translation;
  final String pronunciation;

  TranslationResult({required this.translation, required this.pronunciation});

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      translation: json['translation'] ?? '',
      pronunciation: json['pronunciation'] ?? '',
    );
  }
}

class TranslateModel {
  static const String _systemInstruction = """
Sen Tweety Translator isimli bir çeviri uygulamasında çalışan yapay zekâ destekli bir çevirmen modelsin. 
Görevin verilen metni hedef dile çevirmek ve eğer hedef dil Türkçe değilse Türkçe telaffuzunu da vermektir.

ÖNEMLİ: Yanıtın SADECE JSON formatında olmalı. Başka hiçbir açıklama, metin veya karakter ekleme.

JSON formatı:
{
  "translation": "çeviri metni burada",
  "pronunciation": "türkçe telaffuz burada (sadece hedef dil Türkçe değilse)"
}

Kurallar:
1. SADECE JSON formatında yanıt ver
2. JSON dışında hiçbir metin, açıklama veya karakter ekleme
3. Eğer hedef dil Türkçe ise pronunciation alanını boş string ("") yap
4. Çeviri doğal ve akıcı olsun
5. Türkçe telaffuz, bir Türk'ün nasıl okuyacağını göstersin

Örnek yanıt:
{"translation": "Hello", "pronunciation": "hello"}
""";

  static String _buildPrompt(String text, String targetLang) {
    return "Metin: $text\n\nHedef Dil: $targetLang";
  }

  static Future<TranslationResult> translate(
    String text,
    String targetLang,
  ) async {
    final prompt = _buildPrompt(text, targetLang);
    try {
      final response = await AIService.sendRequest(
        systemInstruction: _systemInstruction,
        userPrompt: prompt,
      );

      String cleanResponse = response.trim();

      if (cleanResponse.startsWith('```json')) {
        cleanResponse = cleanResponse.replaceFirst('```json', '').trim();
      }
      if (cleanResponse.endsWith('```')) {
        cleanResponse = cleanResponse
            .substring(0, cleanResponse.length - 3)
            .trim();
      }

      try {
        final Map<String, dynamic> jsonData = jsonDecode(cleanResponse);
        return TranslationResult.fromJson(jsonData);
      } catch (jsonError) {
        return TranslationResult(
          translation: cleanResponse.isNotEmpty ? cleanResponse : response,
          pronunciation: '',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
