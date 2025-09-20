import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tweety_translator/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Warning: .env file could not be loaded: $e');
  }

  runApp(const TweetyTranslator());
}

class TweetyTranslator extends StatelessWidget {
  const TweetyTranslator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tweety Translator',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFFFDE7),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFFFEB3B),
          foregroundColor: Color(0xFF2E2E2E),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E2E2E),
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFFEB3B),
          secondary: Color(0xFFFFC107),
          surface: Color(0xFFFFF8E1),
          background: Color(0xFFFFFDE7),
          error: Color(0xFFE91E63),
          onPrimary: Color(0xFF2E2E2E),
          onSecondary: Colors.white,
          onSurface: Color(0xFF2E2E2E),
          onBackground: Color(0xFF2E2E2E),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFEB3B),
            foregroundColor: const Color(0xFF2E2E2E),
            elevation: 2,
            shadowColor: Colors.orange.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFF8E1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFFFC107), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFFFC107), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFFF8F00), width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
      initialRoute: '/splash',
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: const Color(0xFFFFFDE7),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEB3B),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '404 - Sayfa Bulunamadı',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Aradığınız sayfa mevcut değil',
                    style: TextStyle(fontSize: 16, color: Color(0xFF616161)),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/'),
                    icon: const Icon(Icons.home),
                    label: const Text('Ana Sayfaya Dön'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
