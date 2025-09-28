import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  String? _selectedState;
  String? _selectedCity;
  
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  
  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();
  
  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPhoneController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();
  final _signUpSportController = TextEditingController();
  
  final List<String> _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
    'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal'
  ];
  
  final Map<String, List<String>> _stateCities = {
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Bikaner', 'Ajmer', 'Bhilwara'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Thane', 'Nashik', 'Aurangabad'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar'],
    // Add more cities as needed
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPhoneController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    _signUpSportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFF8FAFC),
              Color(0xFFF1F5F9),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating circles pattern
            _buildFloatingCircles(),
            
            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Skip button
                  _buildSkipButton(),
                  
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          
                          // Logo & Branding Section
                          _buildLogoSection(),
                          
                          SizedBox(height: 40),
                          
                          // Form Container
                          _buildFormContainer(),
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

  Widget _buildFloatingCircles() {
    return Stack(
      children: [
        // Saffron circle
        Positioned(
          top: 150,
          right: -40,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF6B35).withOpacity(0.04),
            ),
          ),
        ),
        // White circle
        Positioned(
          top: 400,
          left: -50,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFFFFF).withOpacity(0.04),
            ),
          ),
        ),
        // Green circle
        Positioned(
          bottom: 100,
          right: -60,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF059669).withOpacity(0.04),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: EdgeInsets.only(right: 16, top: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/main');
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFFFF6B35).withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
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
              color: Color(0xFFFF6B35).withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFF6B35),
              ),
              child: Center(
                child: Text(
                  'IM',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Sporty',
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Indian Maidan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFF6B35),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Play Bold | Achieve Goal | Get Gold',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1E40AF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFormContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tab Switcher
          _buildTabSwitcher(),
          
          // Form Content
          Container(
            height: _tabController.index == 0 ? 400 : 650, // Different heights for sign in vs sign up
            padding: EdgeInsets.all(24),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSignInForm(),
                _buildSignUpForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Color(0xFF059669),
        unselectedLabelColor: Color(0xFF6B7280),
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        indicatorColor: Color(0xFF059669),
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        tabs: [
          Tab(text: 'Sign In'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  Widget _buildSignInForm() {
    return SingleChildScrollView(
      child: Form(
        key: _signInFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Email Field
            _buildInputField(
              controller: _signInEmailController,
              icon: Icons.mail_outline,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Email is required';
                if (!value!.contains('@')) return 'Invalid email';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // Password Field
            _buildInputField(
              controller: _signInPasswordController,
              icon: Icons.lock_outline,
              hintText: 'Password',
              isPassword: true,
              showPassword: _showPassword,
              onTogglePassword: () => setState(() => _showPassword = !_showPassword),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Password is required';
                return null;
              },
            ),
            SizedBox(height: 16),
            
            // Remember Me & Forgot Password
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value ?? false),
                  activeColor: Color(0xFF059669),
                ),
                Flexible(
                  child: Text(
                    'Remember me for 30 days',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF1E40AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // Submit Button
            _buildSubmitButton('Sign In', () => _handleSignIn()),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Full Name
            _buildInputField(
              controller: _signUpNameController,
              icon: Icons.person_outline,
              hintText: 'Full Name',
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Name is required';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // Email
            _buildInputField(
              controller: _signUpEmailController,
              icon: Icons.mail_outline,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Email is required';
                if (!value!.contains('@')) return 'Invalid email';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // Phone
            _buildInputField(
              controller: _signUpPhoneController,
              icon: Icons.phone_outlined,
              hintText: 'Phone',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Phone is required';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // Password
            _buildInputField(
              controller: _signUpPasswordController,
              icon: Icons.lock_outline,
              hintText: 'Password',
              isPassword: true,
              showPassword: _showPassword,
              onTogglePassword: () => setState(() => _showPassword = !_showPassword),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Password is required';
                if (value!.length < 6) return 'Password must be at least 6 characters';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // Confirm Password
            _buildInputField(
              controller: _signUpConfirmPasswordController,
              icon: Icons.lock_outline,
              hintText: 'Confirm Password',
              isPassword: true,
              showPassword: _showConfirmPassword,
              onTogglePassword: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Confirm password is required';
                if (value != _signUpPasswordController.text) return 'Passwords do not match';
                return null;
              },
            ),
            SizedBox(height: 20),
            
            // State Dropdown
            _buildDropdownField(
              icon: Icons.location_on_outlined,
              hintText: 'Select State',
              value: _selectedState,
              items: _indianStates,
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                  _selectedCity = null;
                });
              },
            ),
            SizedBox(height: 20),
            
            // City Dropdown
            _buildDropdownField(
              icon: Icons.location_city_outlined,
              hintText: 'Select City',
              value: _selectedCity,
              items: _selectedState != null ? _stateCities[_selectedState!] ?? [] : [],
              onChanged: (value) => setState(() => _selectedCity = value),
              enabled: _selectedState != null,
            ),
            SizedBox(height: 20),
            
            // Preferred Sport
            _buildInputField(
              controller: _signUpSportController,
              icon: Icons.sports_football_outlined,
              hintText: 'Preferred Sport',
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Preferred sport is required';
                return null;
              },
            ),
            SizedBox(height: 32),
            
            // Submit Button
            _buildSubmitButton('Create Account', () => _handleSignUp()),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool showPassword = false,
    VoidCallback? onTogglePassword,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword && !showPassword,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color(0xFF1E40AF)),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF6B7280),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF059669), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Container(
      height: 60,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: enabled ? onChanged : null,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: enabled ? Color(0xFF1E40AF) : Color(0xFF9CA3AF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF059669), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubmitButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: _isLoading 
                ? LinearGradient(colors: [Color(0xFF9CA3AF), Color(0xFF9CA3AF)])
                : LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: (_isLoading ? Color(0xFF9CA3AF) : Color(0xFFFF6B35)).withOpacity(0.3),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Container(
            alignment: Alignment.center,
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    if (_signInFormKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      
      // Navigate to main app
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  void _handleSignUp() async {
    if (_signUpFormKey.currentState?.validate() ?? false) {
      if (_selectedState == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a state')),
        );
        return;
      }
      if (_selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a city')),
        );
        return;
      }
      
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      setState(() => _isLoading = false);
      
      // Navigate to main app
      Navigator.pushReplacementNamed(context, '/main');
    }
  }
}