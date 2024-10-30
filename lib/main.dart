
import 'package:flutter/material.dart';
import 'package:final_module/final_module/language_logic.dart';
import 'package:final_module/final_module/theme_logic.dart';
import 'package:provider/provider.dart';
import 'package:final_module/final_module/first_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageLogic()),
        ChangeNotifierProvider(create: (_) => ThemeLogic()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeLogic>(
      builder: (context, themeLogic, child) {
        return MaterialApp(
          theme: themeLogic.currentTheme,  // Apply the current theme
          home: FirstScreen(),             // Set FirstScreen as the home
        );
      },
    );
  }
}

