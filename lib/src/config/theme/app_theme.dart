import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true, // Usa Material 3
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white, // Cambia el color de la flecha de retroceso aquí
        ),
      ),
    );
  }
}