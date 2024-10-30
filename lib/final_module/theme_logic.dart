import 'package:flutter/material.dart';
class ThemeLogic extends ChangeNotifier {
  int _themeIndex = 0;  
  ThemeData _currentTheme = ThemeData.light();

  // Getter for theme index
  int get themeIndex => _themeIndex;

  // Getter for current theme
  ThemeData get currentTheme => _currentTheme;

  // Change to dark theme
  void changeToDark() {
    _themeIndex = 0;
    _currentTheme = ThemeData.dark().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey[400],
      ),
    );
    notifyListeners();
  }

  // Change to light theme
  void changeToLight() {
    _themeIndex = 1;
    _currentTheme = ThemeData.light().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
      ),
    );
    notifyListeners();
  }
}
