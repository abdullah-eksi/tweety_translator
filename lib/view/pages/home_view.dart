import 'package:flutter/material.dart';
import 'package:tweety_translator/controller/home_controller.dart';
import '../components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeController _controller;
  late TextEditingController _inputController;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _inputController = TextEditingController();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleRefresh() {
    _controller.reset();
    _inputController.clear();
    setState(() {});
  }

  void _handleTextChanged(String text) {
    _controller.setInputText(text);
    setState(() {});
  }

  void _handleClear() {
    _inputController.clear();
    _controller.setInputText('');
    setState(() {});
  }

  void _handleExample() {
    _inputController.text = 'Merhaba, nasılsın?';
    _controller.setInputText('Merhaba, nasılsın?');
    setState(() {});
  }

  void _handleCopy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Çeviri kopyalandı!'),
        backgroundColor: Color(0xFFFF8F00),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onRefresh: _handleRefresh),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFDE7), // Açık sarı
              Color(0xFFFFF8E1), // Çok açık sarı
            ],
          ),
        ),
        child: SafeArea(
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(_slideAnimation),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const WelcomeCard(),
                    const SizedBox(height: 24),
                    LanguageSelector(
                      supportedLanguages: _controller.supportedLanguages,
                      selectedLanguage: _controller.selectedLang,
                      onLanguageChanged: (value) {
                        if (value != null) {
                          _controller.changeLanguage(value);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    InputCard(
                      controller: _inputController,
                      onTextChanged: _handleTextChanged,
                      onClear: _handleClear,
                    ),
                    const SizedBox(height: 20),
                    TranslateButton(
                      state: _controller.state,
                      onPressed: () => _controller.translate(),
                    ),
                    const SizedBox(height: 20),
                    ResultCard(
                      state: _controller.state,
                      translatedText: _controller.translatedText,
                      pronunciation: _controller.pronunciation,
                      errorMessage: _controller.errorMessage,
                      onCopy: _handleCopy,
                    ),
                    const SizedBox(height: 24),
                    QuickActionsCard(
                      onClear: _handleRefresh,
                      onExample: _handleExample,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
