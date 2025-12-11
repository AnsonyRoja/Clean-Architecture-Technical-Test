import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFEAF4FD), // fondo claro
    fontFamily: 'Muli',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0057D9),
      onPrimary: Color(0xFF1E2C4A),
      secondary: Color(0xFF3388FF),
      onSecondary: Color.fromARGB(255, 69, 88, 130),
      surface: Colors.white,
      onSurface: Color(0xFF1E2C4A),
      error: Colors.red,
      onError: Color.fromARGB(255, 214, 200, 200),
    ),
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    backgroundColor: Color(0xFF0057D9),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white), // Azul oscuro
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}
