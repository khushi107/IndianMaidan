
import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/providers/auth_provider.dart';
import 'package:indian_maidan_flutter/providers/turf_provider.dart';
import 'package:indian_maidan_flutter/screen/splash/splash_screen.dart';
import 'package:indian_maidan_flutter/providers/bookings_provider.dart';
import 'package:indian_maidan_flutter/providers/explore_provider.dart';
import 'package:indian_maidan_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IndianMaidanApp());
}

class IndianMaidanApp extends StatelessWidget {
  const IndianMaidanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // CORRECTED the typo on the next two lines
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TurfProvider()),
      ],
      child: MaterialApp(
        title: 'Indian Maidan',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const SplashScreen(),
        routes: const {
          // Add routes here as needed
        },
      ),
    );
  }
}