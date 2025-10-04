// lib/screen/auth/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../main_navigation_screen.dart'; 

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  // Login controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Register controllers
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();
  final _registerSportController = TextEditingController();

  String? _selectedState;
  String? _selectedCity;

  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final Map<String, List<String>> _stateCityMap = {
    'Gujarat': ['Ahmedabad', 'Vadodara', 'Surat'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Delhi': ['New Delhi'],
    'Rajasthan': ['Jaipur', 'Udaipur', 'Jodhpur', 'Bikaner'],
    'Karnataka': ['Bengaluru', 'Mysuru'],
  };

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPhoneController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    _registerSportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildSkipButton(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildLogoSection(),
                        const SizedBox(height: 32),
                        _buildTabSwitcher(),
                        const SizedBox(height: 24),
                        _buildFormCard(),
                        const SizedBox(height: 16),
                        _buildToggleLink(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 100,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF6B35).withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF059669).withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: -50,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E40AF).withOpacity(0.04),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
              (route) => false,
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Color(0xFFFF6B35),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFFF6B35).withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFF6B35),
              ),
              child: const Icon(Icons.sports_soccer, size: 50, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Indian Maidan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF6B35),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: const Text(
            'Play Bold | Achieve Goal | Get Gold',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF1E40AF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              isActive: _isLoginMode,
              icon: Icons.login,
              label: 'Sign In',
              onTap: () => setState(() => _isLoginMode = true),
            ),
          ),
          Expanded(
            child: _buildTab(
              isActive: !_isLoginMode,
              icon: Icons.person_add,
              label: 'Sign Up',
              onTap: () => setState(() => _isLoginMode = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required bool isActive,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isActive ? Border.all(color: const Color(0xFF059669), width: 2) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? const Color(0xFF059669) : const Color(0xFF64748B), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF059669) : const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _isLoginMode ? _buildLoginForm() : _buildRegisterForm(),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            controller: _loginEmailController,
            label: 'Email Address*',
            hint: 'your.email@example.com',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!value.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Password*',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 12, color: Color(0xFF1E40AF)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildPasswordField(
            controller: _loginPasswordController,
            hint: 'Enter your password',
            showPassword: _showPassword,
            onToggle: () => setState(() => _showPassword = !_showPassword),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Password is required';
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value ?? false),
                  activeColor: const Color(0xFF059669),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Remember me for 30 days',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSubmitButton('Sign In', _handleLogin),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        children: [
          _buildInputField(
            controller: _registerNameController,
            label: 'Full Name*',
            hint: 'John Doe',
            icon: Icons.person_outline,
            validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: _registerEmailController,
            label: 'Email Address*',
            hint: 'your.email@example.com',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!value.contains('@')) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: _registerPhoneController,
            label: 'Phone Number*',
            hint: '+91 98765 43210',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) return 'Phone is required';
              if (value.length != 10) return 'Enter valid 10-digit phone';
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Password*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 8),
          _buildPasswordField(
            controller: _registerPasswordController,
            hint: 'Create a strong password',
            showPassword: _showPassword,
            onToggle: () => setState(() => _showPassword = !_showPassword),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Password is required';
              if (value.length < 6) return 'Min 6 characters required';
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Confirm Password*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 8),
          _buildPasswordField(
            controller: _registerConfirmPasswordController,
            hint: 'Re-enter your password',
            showPassword: _showConfirmPassword,
            onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Confirm password is required';
              if (value != _registerPasswordController.text) return 'Passwords do not match';
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            label: 'State*',
            hint: 'Select State',
            value: _selectedState,
            items: _stateCityMap.keys.toList(),
            onChanged: (v) => setState(() {
              _selectedState = v;
              _selectedCity = null;
            }),
          ),
          const SizedBox(height: 20),
          _buildDropdownField(
            label: 'City*',
            hint: 'Select City',
            value: _selectedCity,
            items: _selectedState != null ? _stateCityMap[_selectedState!] ?? [] : [],
            onChanged: (v) => setState(() => _selectedCity = v),
            enabled: _selectedState != null,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: _registerSportController,
            label: 'Preferred Sport',
            hint: 'e.g., Football',
            icon: Icons.sports_soccer,
          ),
          const SizedBox(height: 24),
          _buildSubmitButton('Create Account', _handleRegister),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              prefixIcon: Icon(icon, color: const Color(0xFF1E40AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool showPassword,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        obscureText: !showPassword,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1E40AF)),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF64748B)),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? () => _showSelectionModal(label, items, value, onChanged) : null,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: enabled ? const Color(0xFFF3F4F6) : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: enabled ? const Color(0xFF1E40AF) : const Color(0xFF9CA3AF)),
                const SizedBox(width: 12),
                Expanded(child: Text(value ?? hint, style: TextStyle(color: value != null ? const Color(0xFF1E293B) : const Color(0xFF9CA3AF)))),
                Icon(Icons.arrow_drop_down, color: enabled ? const Color(0xFF64748B) : const Color(0xFF9CA3AF)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: _isLoading
                ? const LinearGradient(colors: [Color(0xFF6B7280), Color(0xFF4B5563)])
                : const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isLoginMode ? 'New to Indian Maidan? ' : 'Already have an account? ',
          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),
        TextButton(
          onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            _isLoginMode ? 'Create Account' : 'Sign In',
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E40AF), fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void _showSelectionModal(String title, List<String> items, String? currentValue, ValueChanged<String?> onChanged) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item == currentValue;
                  return ListTile(
                    title: Text(item),
                    trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF059669)) : null,
                    selected: isSelected,
                    selectedTileColor: const Color(0xFF059669).withOpacity(0.1),
                    onTap: () {
                      onChanged(item);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(_loginEmailController.text.trim(), _loginPasswordController.text.trim());

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please check your credentials.'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _handleRegister() async {
    if (!_registerFormKey.currentState!.validate()) return;
    if (_selectedState == null || _selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select state and city')));
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.register(
      name: _registerNameController.text.trim(),
      email: _registerEmailController.text.trim(),
      phone: _registerPhoneController.text.trim(),
      password: _registerPasswordController.text.trim(),
      state: _selectedState!,
      city: _selectedCity!,
      preferredSport: _registerSportController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failed')));
      }
    }
  }
}