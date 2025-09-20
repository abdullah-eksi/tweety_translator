import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  static Future<String> sendRequest({
    required String systemInstruction,
    required String userPrompt,
    double temperature = 0.2,
    int maxOutputTokens = 512,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$geminiBaseUrl?key=$geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'system_instruction': {
            'parts': [
              {'text': systemInstruction},
            ],
          },
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': userPrompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': temperature,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': maxOutputTokens,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null) {
          return text;
        } else {
          throw Exception("TRANSLATION_FORMAT_ERROR");
        }
      } else if (response.statusCode == 401) {
        throw Exception('API_KEY_ERROR');
      } else if (response.statusCode == 429) {
        throw Exception('RATE_LIMIT_ERROR');
      } else if (response.statusCode >= 500) {
        throw Exception('SERVER_ERROR');
      } else {
        throw Exception('API_ERROR');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException') ||
          e.toString().contains('HandshakeException')) {
        throw Exception('NETWORK_ERROR');
      } else if (e.toString().contains('FormatException')) {
        throw Exception('FORMAT_ERROR');
      } else if (e.toString().contains('API_KEY_ERROR') ||
          e.toString().contains('RATE_LIMIT_ERROR') ||
          e.toString().contains('SERVER_ERROR') ||
          e.toString().contains('NETWORK_ERROR') ||
          e.toString().contains('FORMAT_ERROR') ||
          e.toString().contains('TRANSLATION_FORMAT_ERROR')) {
        rethrow;
      } else {
        throw Exception('UNKNOWN_ERROR');
      }
    }
  }
}
