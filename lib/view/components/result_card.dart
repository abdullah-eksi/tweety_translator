import 'package:flutter/material.dart';
import 'package:tweety_translator/controller/home_controller.dart';

/// Çeviri sonucu kartı widget'ı
///
/// Çeviri sonucunu ve varsa telaffuzunu gösterir
class ResultCard extends StatelessWidget {
  final TranslateState state;
  final String translatedText;
  final String pronunciation;
  final String errorMessage;
  final VoidCallback? onCopy;

  const ResultCard({
    super.key,
    required this.state,
    required this.translatedText,
    required this.pronunciation,
    required this.errorMessage,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: state == TranslateState.error
              ? Colors.red
              : const Color(0xFFFFC107),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: state == TranslateState.error
                  ? Colors.red.shade50
                  : const Color(0xFFFFF8E1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  state == TranslateState.error ? Icons.error : Icons.output,
                  color: state == TranslateState.error
                      ? Colors.red
                      : const Color(0xFFFF8F00),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  state == TranslateState.error ? 'Hata' : 'Çeviri Sonucu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: state == TranslateState.error
                        ? Colors.red
                        : const Color(0xFF2E2E2E),
                  ),
                ),
                const Spacer(),
                if (translatedText.isNotEmpty &&
                    state == TranslateState.success &&
                    onCopy != null)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: onCopy,
                    color: const Color(0xFF616161),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildResultContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultContent() {
    switch (state) {
      case TranslateState.idle:
        return Container(
          height: 80,
          alignment: Alignment.center,
          child: Text(
            'Çeviri sonucu burada görünecek...',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      case TranslateState.loading:
        return Container(
          height: 80,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8F00)),
              ),
              const SizedBox(height: 12),
              Text(
                'Çeviri yapılıyor...',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        );
      case TranslateState.success:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Çeviri yazılışı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFC107), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.translate,
                        size: 16,
                        color: Color(0xFFFF8F00),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Yazılışı:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF8F00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    translatedText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E2E2E),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Türkçe telaffuz (sadece varsa göster)
            if (pronunciation.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.record_voice_over,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Türkçe Okunuşu:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      pronunciation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2E2E2E),
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      case TranslateState.error:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        );
    }
  }
}
