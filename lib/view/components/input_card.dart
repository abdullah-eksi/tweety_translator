import 'package:flutter/material.dart';

/// Metin girişi kartı widget'ı
///
/// Kullanıcının çevrilecek metni girdiği alan
class InputCard extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onClear;

  const InputCard({
    super.key,
    required this.controller,
    required this.onTextChanged,
    required this.onClear,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.edit, color: Color(0xFFFF8F00), size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Çevrilecek Metin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E),
                  ),
                ),
                const Spacer(),
                if (controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: onClear,
                    color: const Color(0xFF616161),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              maxLines: 5,
              style: const TextStyle(fontSize: 16, color: Color(0xFF2E2E2E)),
              decoration: InputDecoration(
                hintText: 'Çevirmek istediğiniz metni buraya yazın...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              ),
              onChanged: onTextChanged,
            ),
          ),
        ],
      ),
    );
  }
}
