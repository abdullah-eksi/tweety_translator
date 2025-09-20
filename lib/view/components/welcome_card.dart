import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFEB3B).withOpacity(0.8),
            const Color(0xFFFFC107).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.language,
              size: 40,
              color: Color(0xFFFF8F00),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hoş Geldiniz! 🐥',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Metninizi yazın ve istediğiniz dile çevirin',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
          ),
        ],
      ),
    );
  }
}
