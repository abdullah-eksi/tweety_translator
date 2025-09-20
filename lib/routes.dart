import 'view/page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    splash: (context) => const SplashPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }

  static Future<void> pushNamed(
    BuildContext context,
    String name, {
    Object? arguments,
  }) async {
    await Navigator.pushNamed(context, name, arguments: arguments);
  }

  static Future<void> pushReplacementNamed(
    BuildContext context,
    String name, {
    Object? arguments,
  }) async {
    await Navigator.pushReplacementNamed(context, name, arguments: arguments);
  }

  static Future<void> pushNamedAndRemoveUntil(
    BuildContext context,
    String name, {
    Object? arguments,
  }) async {
    await Navigator.pushNamedAndRemoveUntil(
      context,
      name,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future<void> goFromSplash(BuildContext context) async {
    await pushReplacementNamed(context, home);
  }
}

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final Offset begin;

  SlideRoute({required this.page, this.begin = const Offset(1.0, 0.0)})
    : super(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          var slideAnimation = Tween(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(position: slideAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
    : super(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({required this.page})
    : super(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.elasticOut),
          );
          return ScaleTransition(scale: scaleAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      );
}
