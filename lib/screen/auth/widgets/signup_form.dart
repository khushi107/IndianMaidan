// lib/screen/auth/widgets/signup_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/colors.dart';
import '../../home/home_screen.dart';
import '../../main_navigation_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? state;
  String? city;
  final _sport = TextEditingController();
  bool obscure1 = true, obscure2 = true;
  bool loading = false;

  final states = const ['Gujarat','Maharashtra','Delhi','Rajasthan','Karnataka']; // expand later dynamically
  final citiesMap = const {
    'Gujarat':['Ahmedabad','Vadodara','Surat'],
    'Maharashtra':['Mumbai','Pune','Nagpur'],
    'Delhi':['New Delhi'],
    'Rajasthan':['Jaipur','Udaipur','Jodhpur'],
    'Karnataka':['Bengaluru','Mysuru'],
  };

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final cities = state==null ? <String>[] : citiesMap[state] ?? [];

    return Form(
      key: _form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(prefixIcon: Icon(Icons.person, color: AppColors.navy), labelText: 'Full Name'),
              validator: (v)=> (v??'').isNotEmpty ? null : 'Required',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(prefixIcon: Icon(Icons.mail, color: AppColors.navy), labelText: 'Email'),
              validator: (v)=> v!=null && v.contains('@') ? null : 'Enter a valid email',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(prefixIcon: Icon(Icons.call, color: AppColors.navy), labelText: 'Phone Number'),
              validator: (v)=> (v??'').length>=10 ? null : 'Enter valid phone',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _password,
              obscureText: obscure1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: AppColors.navy),
                labelText: 'Password',
                suffixIcon: IconButton(icon: Icon(obscure1?Icons.visibility:Icons.visibility_off), onPressed: ()=>setState(()=>obscure1=!obscure1)),
              ),
              validator: (v)=> (v??'').length>=6 ? null : 'Min 6 chars',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirm,
              obscureText: obscure2,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: AppColors.navy),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(icon: Icon(obscure2?Icons.visibility:Icons.visibility_off), onPressed: ()=>setState(()=>obscure2=!obscure2)),
              ),
              validator: (v)=> v==_password.text ? null : 'Passwords don\'t match',
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: state,
              items: states.map((s)=>DropdownMenuItem(value:s, child: Text(s))).toList(),
              onChanged: (v)=>setState(()=>state=v),
              decoration:  InputDecoration(prefixIcon: Icon(Icons.location_pin, color: AppColors.navy), labelText: 'State'),
              validator: (v)=> v!=null ? null : 'Select state',
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: city,
              items: cities.map((c)=>DropdownMenuItem(value:c, child: Text(c))).toList(),
              onChanged: (v)=>setState(()=>city=v),
              decoration:  InputDecoration(prefixIcon: Icon(Icons.location_city, color: AppColors.navy), labelText: 'City'),
              validator: (v)=> v!=null ? null : 'Select city',
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sport,
              decoration:  InputDecoration(prefixIcon: Icon(Icons.sports_soccer, color: AppColors.navy), labelText: 'Preferred Sport'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : () async {
                if (!_form.currentState!.validate()) return;
                setState(()=>loading=true);
                final ok = await auth.register(
                  name: _name.text.trim(),
                  email: _email.text.trim(),
                  phone: _phone.text.trim(),
                  password: _password.text.trim(),
                  state: state!,
                  city: city!,
                  preferredSport: _sport.text.trim(),
                );
                setState(()=>loading=false);
                if (ok && context.mounted) {
  // later: navigate to OTP screen
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    (route) => false,
  );
} else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failed')));
                  }
                }
              },
              child: Text(loading ? 'Please wait...' : 'Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
