import 'package:flutter/material.dart';

/// Dil seçici widget'ı
///
/// Kullanıcının çeviri dili seçmesini sağlar
class LanguageSelector extends StatelessWidget {
  final List<String> supportedLanguages;
  final String selectedLanguage;
  final ValueChanged<String?> onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.supportedLanguages,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFC107), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEB3B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.translate,
                  color: Color(0xFF2E2E2E),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Çeviri Dili Seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFC107)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLanguage,
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF616161),
                ),
                style: const TextStyle(color: Color(0xFF2E2E2E), fontSize: 16),
                items: supportedLanguages.map((language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getLanguageColor(language),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            language,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onLanguageChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getLanguageColor(String language) {
    final colors = [
      const Color(0xFFFF8F00),
      const Color(0xFFFFC107),
      const Color(0xFFFFEB3B),
      const Color(0xFF4CAF50),
      const Color(0xFF2196F3),
      const Color(0xFF9C27B0),
      const Color(0xFFE91E63),
      const Color(0xFF795548),
    ];
    return colors[language.hashCode % colors.length];
  }
}
