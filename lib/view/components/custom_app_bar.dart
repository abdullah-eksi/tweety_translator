import 'package:flutter/material.dart';

/// Özel AppBar widget'ı
///
/// Tweety Translator için özelleştirilmiş app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;

  const CustomAppBar({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFFFEB3B),
      automaticallyImplyLeading: false, // Geri ikonunu kaldır
      centerTitle: true, // Başlığı ortala
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              'assets/tweety.png',
              width: 28,
              height: 28,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.translate,
                  color: Color(0xFFFF8F00),
                  size: 28,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Tweety Translator',
            style: TextStyle(
              color: Color(0xFF2E2E2E),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Color(0xFF2E2E2E)),
          onPressed: onRefresh,
          tooltip: 'Temizle',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
