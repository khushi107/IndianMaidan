// lib/main.dart
import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/providers/auth_provider.dart';
import 'package:indian_maidan_flutter/providers/turf_provider.dart';
import 'package:indian_maidan_flutter/screen/splash/splash_screen.dart';
import 'package:indian_maidan_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IndianMaidanApp());
}

class IndianMaidanApp extends StatelessWidget {
  const IndianMaidanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TurfProvider()),
      ],
      child: MaterialApp(
        title: 'Indian Maidan',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}