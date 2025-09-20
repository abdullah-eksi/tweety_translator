import 'package:flutter/material.dart';
import '../model/translate_model.dart';

enum TranslateState { idle, loading, success, error }

class HomeController extends ChangeNotifier {
  String inputText = "";
  String selectedLang = "Türkçe";
  String translatedText = "";
  String pronunciation = "";

  final List<String> supportedLanguages = [
    "Türkçe",
    "Azerbaycan Türkçesi",
    "Kazakça",
    "Kırgızca",
    "Özbekçe",
    "Türkmence",
    "İngilizce",
    "Almanca",
    "Fransızca",
    "İspanyolca",
    "İtalyanca",
    "Rusça",
    "Çince",
    "Japonca",
  ];

  TranslateState state = TranslateState.idle;
  String errorMessage = "";

  Future<void> translate() async {
    if (inputText.trim().isEmpty) {
      errorMessage = "Lütfen çevirmek için bir metin girin.";
      state = TranslateState.error;
      notifyListeners();
      return;
    }

    state = TranslateState.loading;
    translatedText = "";
    errorMessage = "";
    notifyListeners();

    try {
      final result = await TranslateModel.translate(inputText, selectedLang);

      translatedText = result.translation;
      pronunciation = result.pronunciation;
      state = TranslateState.success;
      notifyListeners();
    } catch (e) {
      translatedText = "";
      pronunciation = "";
      errorMessage = _getUserFriendlyErrorMessage(e.toString());
      state = TranslateState.error;
      notifyListeners();
    }
  }

  String _getUserFriendlyErrorMessage(String error) {
    if (error.contains('NETWORK_ERROR')) {
      return '🌐 İnternet bağlantınızı kontrol edip tekrar deneyin';
    } else if (error.contains('API_KEY_ERROR')) {
      return '🔑 API anahtarı sorunu - uygulama geliştiricisi ile iletişime geçin';
    } else if (error.contains('RATE_LIMIT_ERROR')) {
      return '⏳ Çok fazla istek gönderildi, lütfen biraz bekleyip tekrar deneyin';
    } else if (error.contains('SERVER_ERROR')) {
      return '🔧 Sunucu geçici olarak kullanılamıyor, lütfen daha sonra tekrar deneyin';
    } else if (error.contains('FORMAT_ERROR') ||
        error.contains('TRANSLATION_FORMAT_ERROR') ||
        error.contains('FormatException') ||
        error.contains('Unexpected character')) {
      return '📝 Çeviri formatında sorun oluştu, farklı bir metin deneyin';
    } else {
      return '❌ Çeviri sırasında bir hata oluştu, daha sonra tekrar deneyin';
    }
  }

  void changeLanguage(String lang) {
    if (supportedLanguages.contains(lang)) {
      selectedLang = lang;
      notifyListeners();
    }
  }

  void setInputText(String text) {
    inputText = text;
    notifyListeners();
  }

  void reset() {
    inputText = "";
    translatedText = "";
    pronunciation = "";
    selectedLang = "Türkçe";
    state = TranslateState.idle;
    errorMessage = "";
    notifyListeners();
  }

  Future<void> quickTranslate(String text, String lang) async {
    setInputText(text);
    changeLanguage(lang);
    await translate();
  }
}
