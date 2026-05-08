import 'package:flutter/material.dart';

import 'core/app_theme.dart';
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
      theme: AppTheme.light,
      home: const RoleSelectionScreen(),
    );
  }
}