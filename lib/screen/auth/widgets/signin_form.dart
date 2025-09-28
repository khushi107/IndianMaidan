// lib/screen/auth/widgets/signin_form.dart

import 'package:flutter/material.dart';
import 'package:indian_maidan_flutter/screen/main_navigation_screen.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_button.dart'; // Using the custom button

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return; // Invalid form
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (success) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (ctx) => const MainNavigationScreen()),
    (route) => false,
  );
} else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.primaryNavy),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryNavy),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.midGrey),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                CustomButton(
                  text: 'Sign In',
                  onPressed: _submit,
                ),
            ],
          ),
        ),
      ),
    );
  }
}