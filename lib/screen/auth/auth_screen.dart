import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/utils/colors.dart';
import 'widgets/signin_form.dart';
import 'widgets/signup_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient BG
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.bgTop, AppColors.bgMid, AppColors.bgBottom],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Top row with Skip
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                        child: const Text('Skip', style: TextStyle(color: AppColors.saffron, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Logo + Title + Tagline
                  Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.saffron.withOpacity(.2), width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0,6))],
                    ),
                    child: Center(child: Image.asset('assets/images/logo.png', width: 100, height: 100)),
                  ),
                  const SizedBox(height: 12),
                  const Text('Indian Maidan', style: TextStyle(color: AppColors.saffron, fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('Play Bold | Achieve Goal | Get Gold', style: TextStyle(color: AppColors.navy)),
                  const SizedBox(height: 16),

                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0,6))],
                    ),
                    child: TabBar(
                      controller: _tab,
                      indicatorColor: AppColors.green,
                      labelColor: AppColors.green,
                      unselectedLabelColor: const Color(0xFF6B7280),
                      tabs: const [Tab(text: 'Sign In'), Tab(text: 'Sign Up')],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Form Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0,8))],
                      ),
                      child: TabBarView(
                        controller: _tab,
                        children: const [
                          SignInForm(),
                          SignUpForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
