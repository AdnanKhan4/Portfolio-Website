import 'package:flutter/material.dart';
import 'package:portfolio_web/Responsive/SplashScreen.dart';
import 'package:provider/provider.dart';



class ThemeNotifier extends ChangeNotifier {
  bool isDark = false;


  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return isDark ? ThemeData.dark() : ThemeData.light();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const PortfolioWebsite(),
    ),
  );
}

class PortfolioWebsite extends StatelessWidget {
  const PortfolioWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Adnan Khan\'s Portfolio',
          theme: themeNotifier.currentTheme.copyWith(
            primaryColor: Colors.blue, 
            textTheme: themeNotifier.currentTheme.textTheme.apply(
              fontFamily: 'Montserrat', 
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
