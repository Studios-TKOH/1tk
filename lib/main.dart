import 'package:flutter/material.dart';
import 'screens/auth/role_selection_screen.dart';

void main() {
  runApp(const TKOHApp());
}

class TKOHApp extends StatelessWidget {
  const TKOHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnToque TKOH',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF7FAFC),
          elevation: 0,
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}
