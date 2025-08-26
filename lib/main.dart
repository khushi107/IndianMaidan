import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/turf_provider.dart';
import 'screen/splash/splash_screen.dart';
import 'screen/auth/auth_screen.dart';
import 'screen/home/home_screen.dart';

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TurfProvider()),
      ],
      child: MaterialApp(
        title: 'Indian Maidan',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        routes: {
          '/auth/player': (_) => const AuthScreen(),
          '/home': (_) => const HomeScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
