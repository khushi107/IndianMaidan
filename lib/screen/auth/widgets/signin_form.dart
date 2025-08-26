import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/colors.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool remember = false;
  bool obscure = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.mail, color: AppColors.navy), labelText: 'Email'),
            validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email',
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _password,
            obscureText: obscure,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: AppColors.navy),
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => obscure = !obscure),
              ),
            ),
            validator: (v) => (v ?? '').length >= 6 ? null : 'Min 6 chars',
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: remember, onChanged: (v)=>setState(()=>remember=v??false)),
              const Text('Remember me for 30 days', style: TextStyle(color: Color(0xFF6B7280))),
              const Spacer(),
              TextButton(onPressed: (){}, child: const Text('Forgot Password')),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: loading ? null : () async {
              if (!_form.currentState!.validate()) return;
              setState(()=>loading=true);
              final ok = await auth.login(_email.text.trim(), _password.text.trim());
              setState(()=>loading=false);
              if (ok) {
                if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
              } else {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login failed')),
                );
              }
            },
            child: Text(loading ? 'Please wait...' : 'Sign In'),
          ),
        ],
      ),
    );
  }
}
