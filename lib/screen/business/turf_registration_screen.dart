// lib/screen/business/turf_registration_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class TurfRegistrationScreen extends StatefulWidget {
  const TurfRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<TurfRegistrationScreen> createState() => _TurfRegistrationScreenState();
}

class _TurfRegistrationScreenState extends State<TurfRegistrationScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  // Step 1 controllers
  final _step1FormKey = GlobalKey<FormState>();
  final _turfNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedState;
  String? _selectedCity;
  double? _latitude;
  double? _longitude;
  bool _locating = false;

  // Step 2: Sports
  final List<SportConfig> _sports = [];

  // Step 3: Amenities
  final _descriptionController = TextEditingController();
  final List<String> _selectedAmenities = [];

  // Data
  final Map<String, List<String>> _stateCityMap = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada', 'Guntur'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Bikaner', 'Ajmer'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Thane', 'Nashik'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore'],
    'Delhi': ['New Delhi', 'North Delhi', 'South Delhi'],
  };

  final List<Map<String, dynamic>> _sportOptions = [
    {'id': 'football', 'name': 'Football', 'icon': Icons.sports_soccer},
    {'id': 'cricket', 'name': 'Cricket', 'icon': Icons.sports_cricket},
    {'id': 'badminton', 'name': 'Badminton', 'icon': Icons.sports_tennis},
    {'id': 'tennis', 'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'id': 'basketball', 'name': 'Basketball', 'icon': Icons.sports_basketball},
    {'id': 'swimming', 'name': 'Swimming', 'icon': Icons.pool},
    {'id': 'table_tennis', 'name': 'Table Tennis', 'icon': Icons.table_restaurant},
    {'id': 'gym', 'name': 'Gym/Fitness', 'icon': Icons.fitness_center},
  ];

  final Map<String, List<String>> _sportCourtSizes = {
    'football': ['110x70 yards (International)', '50x30 yards (6-a-side)', '40x20 yards (5-a-side)'],
    'cricket': ['22 yards (Full Pitch)', 'Box Cricket 30m x 20m'],
    'badminton': ['44x17 feet (Singles)', '44x20 feet (Doubles)'],
    'tennis': ['78x27 feet (Singles)', '78x36 feet (Doubles)'],
    'basketball': ['94x50 feet (Full Court)', 'Half Court (47x50 ft)'],
    'swimming': ['50m x 25m (Olympic)', '25m x 21m (Short Course)', '20m x 10m (Training)'],
    'table_tennis': ['Standard Table (9x5 ft)', 'Tournament Table'],
    'gym': ['Small Studio (500-1000 sq ft)', 'Medium Gym (1000-2000 sq ft)'],
  };

  final List<Map<String, dynamic>> _surfaceOptions = [
    {'id': 'artificial_grass', 'name': 'Artificial Grass', 'icon': Icons.grass},
    {'id': 'natural_grass', 'name': 'Natural Grass', 'icon': Icons.grass},
    {'id': 'concrete', 'name': 'Concrete', 'icon': Icons.construction},
    {'id': 'wooden', 'name': 'Wooden', 'icon': Icons.business},
    {'id': 'rubber', 'name': 'Rubber', 'icon': Icons.construction},
  ];

  final Map<String, List<Map<String, dynamic>>> _surfaceOptionsBySport = {
    'swimming': [
      {'id': 'indoor_pool', 'name': 'Indoor Pool', 'icon': Icons.business},
      {'id': 'outdoor_pool', 'name': 'Outdoor Pool', 'icon': Icons.wb_sunny},
      {'id': 'temperature_controlled', 'name': 'Temperature Controlled', 'icon': Icons.thermostat},
    ],
    'gym': [
      {'id': 'rubber_flooring', 'name': 'Rubber Flooring', 'icon': Icons.construction},
      {'id': 'wooden_flooring', 'name': 'Wooden Flooring', 'icon': Icons.business},
      {'id': 'vinyl_flooring', 'name': 'Vinyl Flooring', 'icon': Icons.construction},
    ],
  };

  final List<String> _timeSlots = List.generate(36, (i) {
    final hour = (i + 10) ~/ 2;
    final minute = (i % 2) * 30;
    final h = hour.toString().padLeft(2, '0');
    final m = minute == 0 ? '00' : '30';
    return '$h:$m';
  });

  final List<Map<String, dynamic>> _amenitiesOptions = [
    {'id': 'parking', 'name': 'Parking', 'icon': Icons.local_parking},
    {'id': 'wifi', 'name': 'Wi-Fi', 'icon': Icons.wifi},
    {'id': 'washroom', 'name': 'Washroom', 'icon': Icons.wc},
    {'id': 'shower', 'name': 'Shower', 'icon': Icons.shower},
    {'id': 'cafeteria', 'name': 'Cafeteria', 'icon': Icons.restaurant},
    {'id': 'waiting_area', 'name': 'Waiting Area', 'icon': Icons.event_seat},
    {'id': 'lockers', 'name': 'Lockers', 'icon': Icons.lock},
    {'id': 'first_aid', 'name': 'First Aid', 'icon': Icons.medical_services},
    {'id': 'cctv', 'name': 'CCTV Security', 'icon': Icons.security},
    {'id': 'lighting', 'name': 'Floodlights', 'icon': Icons.light_mode},
  ];

  @override
  void dispose() {
    _turfNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    for (var sport in _sports) {
      sport.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStepIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildCurrentStep(),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)]),
        border: Border(bottom: BorderSide(color: Color(0xFFE65100), width: 2)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Turf Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                Text('Step ${_currentStep + 1} of 3', style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        children: [
          _buildStepCircle(0, 'Basic Info'),
          _buildStepLine(0),
          _buildStepCircle(1, 'Sports'),
          _buildStepLine(1),
          _buildStepCircle(2, 'Amenities'),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    final isCompleted = _currentStep > step;
    final isActive = _currentStep == step;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted || isActive ? const Color(0xFFE65100) : const Color(0xFFE5E7EB),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text('${step + 1}', style: TextStyle(color: isActive ? Colors.white : const Color(0xFF64748B), fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: isActive || isCompleted ? const Color(0xFF1E293B) : const Color(0xFF64748B), fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildStepLine(int step) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        color: _currentStep > step ? const Color(0xFFE65100) : const Color(0xFFE5E7EB),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildStep1BasicInfo();
      case 1:
        return _buildStep2Sports();
      case 2:
        return _buildStep3Amenities();
      default:
        return Container();
    }
  }

  // STEP 1
  Widget _buildStep1BasicInfo() {
    return Form(
      key: _step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Basic Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(height: 8),
          const Text('Tell us about your facility and contact details', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
          const SizedBox(height: 20),
          _buildInputField(controller: _turfNameController, label: 'Turf Name*', hint: 'e.g., Champions Sports Arena', icon: Icons.sports_soccer, validator: (v) => v?.isEmpty ?? true ? 'Required' : null),
          const SizedBox(height: 20),
          _buildInputField(controller: _phoneController, label: 'Phone Number*', hint: '+91 98765 43210', icon: Icons.phone, keyboardType: TextInputType.phone, validator: (v) => (v?.length ?? 0) < 10 ? 'Invalid phone' : null),
          const SizedBox(height: 20),
          _buildInputField(controller: _emailController, label: 'Email*', hint: 'facility@email.com', icon: Icons.email, keyboardType: TextInputType.emailAddress, validator: (v) => !(v?.contains('@') ?? false) ? 'Invalid email' : null),
          const SizedBox(height: 20),
          _buildInputField(controller: _addressController, label: 'Complete Address*', hint: 'Enter complete address', icon: Icons.location_on, maxLines: 3, validator: (v) => v?.isEmpty ?? true ? 'Required' : null),
          const SizedBox(height: 20),
          _buildLocationPicker(),
          const SizedBox(height: 20),
          _buildDropdownField(label: 'State*', hint: 'Select State', value: _selectedState, items: _stateCityMap.keys.toList(), onChanged: (v) => setState(() { _selectedState = v; _selectedCity = null; })),
          const SizedBox(height: 20),
          _buildDropdownField(label: 'City*', hint: 'Select City', value: _selectedCity, items: _selectedState != null ? _stateCityMap[_selectedState!] ?? [] : [], onChanged: (v) => setState(() => _selectedCity = v), enabled: _selectedState != null),
        ],
      ),
    );
  }

  Widget _buildLocationPicker() {
    return GestureDetector(
      onTap: () async {
        setState(() => _locating = true);
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _latitude = 26.9124;
          _longitude = 75.7873;
          _selectedState = 'Rajasthan';
          _selectedCity = 'Bikaner';
          _addressController.text = 'Near Railway Station, Bikaner';
          _locating = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location detected! Address auto-filled'), backgroundColor: Color(0xFF10B981)),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE65100).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE65100).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: Color(0xFFE65100), shape: BoxShape.circle),
              child: const Icon(Icons.my_location, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Use my current location', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  Text(
                    _locating
                        ? 'Detecting location...'
                        : _latitude != null
                            ? 'Lat: ${_latitude!.toStringAsFixed(4)}, Lng: ${_longitude!.toStringAsFixed(4)}'
                            : 'Auto-fill latitude and longitude',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFE65100)),
          ],
        ),
      ),
    );
  }

  // STEP 2
  Widget _buildStep2Sports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sports Configuration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        const Text('Configure sports, pricing, and operating hours', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
        const SizedBox(height: 20),
        ..._sports.asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 16), child: _buildSportCard(e.key, e.value))),
        _buildAddSportButton(),
      ],
    );
  }

  Widget _buildAddSportButton() {
    return GestureDetector(
      onTap: () => setState(() => _sports.add(SportConfig())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE65100), width: 2, style: BorderStyle.solid)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: Color(0xFFE65100)),
            const SizedBox(width: 8),
            Text(_sports.isEmpty ? 'Add Sport' : 'Add Another Sport', style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildSportCard(int index, SportConfig sport) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sport ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              IconButton(onPressed: () => setState(() => _sports.removeAt(index)), icon: const Icon(Icons.close, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 16),
          _buildSportTypeSelector(sport),
          const SizedBox(height: 16),
          _buildCourtCountStepper(sport),
          if (sport.totalCourts > 1) ...[
            const SizedBox(height: 16),
            _buildDifferentSpecsToggle(sport),
          ],
          const SizedBox(height: 16),
          sport.hasDifferentSpecs && sport.totalCourts > 1 ? _buildIndividualCourtConfigs(sport) : _buildUniformConfig(sport),
        ],
      ),
    );
  }

  Widget _buildSportTypeSelector(SportConfig sport) {
    return GestureDetector(
      onTap: () => _showSportTypeModal(sport),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Icon(sport.type != null ? _sportOptions.firstWhere((s) => s['id'] == sport.type, orElse: () => _sportOptions[0])['icon'] : Icons.sports, color: const Color(0xFF1E40AF)),
            const SizedBox(width: 12),
            Expanded(child: Text(sport.type != null ? _sportOptions.firstWhere((s) => s['id'] == sport.type, orElse: () => {'name': 'Unknown'})['name'] : 'Select Sport Type*', style: TextStyle(color: sport.type != null ? const Color(0xFF1E293B) : const Color(0xFF9CA3AF)))),
            const Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtCountStepper(SportConfig sport) {
    final label = _getCourtLabel(sport.type);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: sport.totalCourts > 1
                    ? () => setState(() {
                          sport.totalCourts--;
                          if (sport.totalCourts == 1) {
                            sport.hasDifferentSpecs = false; // KEY: Reset toggle when count becomes 1
                          }
                        })
                    : null,
                icon: const Icon(Icons.remove),
                color: const Color(0xFFE65100),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Text('${sport.totalCourts}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              ),
              IconButton(onPressed: () => setState(() => sport.totalCourts++), icon: const Icon(Icons.add), color: const Color(0xFFE65100)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDifferentSpecsToggle(SportConfig sport) {
    final label = _getSingularCourtLabel(sport.type);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Different specifications for each $label?', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)))),
              Switch(
                value: sport.hasDifferentSpecs,
                onChanged: (v) {
                  setState(() {
                    sport.hasDifferentSpecs = v;
                    if (v) {
                      _initializeIndividualCourts(sport); // KEY: Initialize courts with defaults
                    }
                  });
                },
                activeColor: const Color(0xFFE65100),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Enable if your ${label.toLowerCase()}s have different surface types, sizes, or pricing', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  void _initializeIndividualCourts(SportConfig sport) {
    // KEY: Initialize courts with parent sport's default values
    sport.courts = List.generate(
      sport.totalCourts,
      (index) => CourtConfig(
        name: '${_getSingularCourtLabel(sport.type)} ${String.fromCharCode(65 + index)}',
        surfaceType: sport.surfaceType,
        courtSize: sport.courtSize,
      )..weekdayPriceController.text = sport.weekdayPriceController.text
        ..weekendPriceController.text = sport.weekendPriceController.text,
    );
  }

  Widget _buildUniformConfig(SportConfig sport) {
    return Column(
      children: [
        _buildSurfaceDropdown(sport, null),
        const SizedBox(height: 16),
        _buildSizeDropdown(sport, null),
        const SizedBox(height: 16),
        _buildCustomSizeField(sport, null),
        const SizedBox(height: 16),
        _buildPricingRow(sport, null),
        const SizedBox(height: 16),
        _buildOperatingHours(sport),
      ],
    );
  }

  Widget _buildIndividualCourtConfigs(SportConfig sport) {
    final label = _getSingularCourtLabel(sport.type);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Configure Each $label', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 16),
        ...List.generate(sport.totalCourts, (index) {
          if (index >= sport.courts.length) return const SizedBox();
          final court = sport.courts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(court.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_circle, size: 12, color: Color(0xFF10B981)), SizedBox(width: 4), Text('Active', style: TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.w600))]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSurfaceDropdown(sport, index),
                  const SizedBox(height: 12),
                  _buildSizeDropdown(sport, index),
                  const SizedBox(height: 12),
                  _buildCustomSizeField(sport, index),
                  const SizedBox(height: 12),
                  _buildPricingRow(sport, index),
                ],
              ),
            ),
          );
        }),
        _buildOperatingHours(sport),
      ],
    );
  }

  Widget _buildSurfaceDropdown(SportConfig sport, int? courtIndex) {
    final surfaces = sport.type != null && _surfaceOptionsBySport.containsKey(sport.type)
        ? _surfaceOptionsBySport[sport.type]!
        : _surfaceOptions;

    String? currentValue;
    if (courtIndex == null) {
      currentValue = sport.surfaceType;
    } else if (courtIndex < sport.courts.length) {
      currentValue = sport.courts[courtIndex].surfaceType;
    }

    return GestureDetector(
      onTap: () => _showSelectionModal(
        'Surface Type',
        surfaces.map((s) => s['name'] as String).toList(),
        currentValue,
        (v) {
          setState(() {
            final selectedId = surfaces.firstWhere((s) => s['name'] == v)['id'];
            if (courtIndex == null) {
              sport.surfaceType = selectedId;
            } else if (courtIndex < sport.courts.length) {
              sport.courts[courtIndex].surfaceType = selectedId;
            }
          });
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Surface Type*', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.grass, color: Color(0xFF1E40AF)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    currentValue != null ? surfaces.firstWhere((s) => s['id'] == currentValue, orElse: () => {'name': 'Select Surface'})['name'] : 'Select Surface',
                    style: TextStyle(color: currentValue != null ? const Color(0xFF1E293B) : const Color(0xFF9CA3AF)),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeDropdown(SportConfig sport, int? courtIndex) {
    final sizes = sport.type != null ? _sportCourtSizes[sport.type] ?? [] : [];

    String? currentValue;
    if (courtIndex == null) {
      currentValue = sport.courtSize;
    } else if (courtIndex < sport.courts.length) {
      currentValue = sport.courts[courtIndex].courtSize;
    }

    return GestureDetector(
      onTap: sport.type != null
          ? () => _showSelectionModal(
                'Court Size',
                //sizes,
                sizes.cast<String>(),
                currentValue,
                (v) {
                  setState(() {
                    if (courtIndex == null) {
                      sport.courtSize = v;
                    } else if (courtIndex < sport.courts.length) {
                      sport.courts[courtIndex].courtSize = v;
                    }
                  });
                },
              )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${_getCourtLabel(sport.type)} Size', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: sport.type != null ? const Color(0xFFF3F4F6) : const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Icon(Icons.straighten, color: sport.type != null ? const Color(0xFF1E40AF) : const Color(0xFF9CA3AF)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    currentValue ?? (sport.type != null ? 'Select Size' : 'Select Sport First'),
                    style: TextStyle(color: currentValue != null ? const Color(0xFF1E293B) : const Color(0xFF9CA3AF)),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSizeField(SportConfig sport, int? courtIndex) {
    TextEditingController controller;
    if (courtIndex == null) {
      controller = sport.customSizeController;
    } else if (courtIndex < sport.courts.length) {
      controller = sport.courts[courtIndex].customSizeController;
    } else {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Other / Custom Size', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Type custom size (e.g., 42x22 meters)',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              prefixIcon: Icon(Icons.straighten, color: Color(0xFF1E40AF)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPricingRow(SportConfig sport, int? courtIndex) {
    TextEditingController weekdayController;
    TextEditingController weekendController;

    if (courtIndex == null) {
      weekdayController = sport.weekdayPriceController;
      weekendController = sport.weekendPriceController;
    } else if (courtIndex < sport.courts.length) {
      weekdayController = sport.courts[courtIndex].weekdayPriceController;
      weekendController = sport.courts[courtIndex].weekendPriceController;
    } else {
      return const SizedBox();
    }

    return Row(
      children: [
        Expanded(child: _buildPriceField('Weekday Rate (₹/hour)*', weekdayController)),
        const SizedBox(width: 12),
        Expanded(child: _buildPriceField('Weekend Rate (₹/hour)*', weekendController)),
      ],
    );
  }

  Widget _buildPriceField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const Text('₹', style: TextStyle(color: Color(0xFF64748B))),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(hintText: '500', border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                ),
              ),
              const Text('/hour', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOperatingHours(SportConfig sport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Operating Hours*', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildTimeDropdown('Opening', sport.openingTime, (v) => setState(() => sport.openingTime = v))),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('to', style: TextStyle(color: Color(0xFF64748B)))),
            Expanded(child: _buildTimeDropdown('Closing', sport.closingTime, (v) => setState(() => sport.closingTime = v))),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeDropdown(String label, String value, ValueChanged<String> onChanged) {
    return GestureDetector(
      onTap: () => _showSelectionModal(label, _timeSlots, value, (v) => onChanged(v ?? value)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Color(0xFF1E40AF)),
            const SizedBox(width: 12),
            Expanded(child: Text(value)),
            const Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  // STEP 3
  Widget _buildStep3Amenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Amenities & Images', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        const Text('Select available amenities and upload facility images', style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
        const SizedBox(height: 20),
        _buildInputField(controller: _descriptionController, label: 'Facility Description', hint: 'Describe your facility, special features...', icon: Icons.description, maxLines: 4),
        const SizedBox(height: 24),
        const Text('Available Amenities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _amenitiesOptions.map((amenity) {
            final isSelected = _selectedAmenities.contains(amenity['id']);
            return GestureDetector(
              onTap: () => setState(() {
                if (isSelected) {
                  _selectedAmenities.remove(amenity['id']);
                } else {
                  _selectedAmenities.add(amenity['id']);
                }
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE65100) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? const Color(0xFFE65100) : const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(amenity['icon'], size: 20, color: isSelected ? Colors.white : const Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    Text(amenity['name'], style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1E293B), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text('Facility Images', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image picker - Add image_picker package'), backgroundColor: Color(0xFF1E40AF)),
            );
          },
          child: Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE65100), width: 2)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt, size: 48, color: Color(0xFFE65100)), SizedBox(height: 8), Text('Upload Images', style: TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.w600, fontSize: 16)), SizedBox(height: 4), Text('Tap to add facility photos', style: TextStyle(color: Color(0xFF64748B), fontSize: 12))]),
          ),
        ),
      ],
    );
  }

  // NAVIGATION
  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(child: OutlinedButton(onPressed: () => setState(() => _currentStep--), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: const BorderSide(color: Color(0xFFE5E7EB)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.arrow_back, size: 18, color: Color(0xFF64748B)), SizedBox(width: 8), Text('Previous', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600))]))),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleNext,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Ink(
                decoration: BoxDecoration(gradient: _isLoading ? const LinearGradient(colors: [Color(0xFF6B7280), Color(0xFF4B5563)]) : _currentStep < 2 ? const LinearGradient(colors: [Color(0xFFE65100), Color(0xFFFF6F00)]) : const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]), borderRadius: BorderRadius.circular(12)),
                child: Container(padding: const EdgeInsets.symmetric(vertical: 16), alignment: Alignment.center, child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(_currentStep < 2 ? 'Next' : 'Register Facility', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)), const SizedBox(width: 8), Icon(_currentStep < 2 ? Icons.arrow_forward : Icons.check, color: Colors.white, size: 18)])),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HELPERS
  Widget _buildInputField({required TextEditingController controller, required String label, required String hint, required IconData icon, int maxLines = 1, TextInputType? keyboardType, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
          child: TextFormField(controller: controller, maxLines: maxLines, keyboardType: keyboardType, validator: validator, decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Color(0xFF9CA3AF)), prefixIcon: Icon(icon, color: const Color(0xFF1E40AF)), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
        ),
      ],
    );
  }

  Widget _buildDropdownField({required String label, required String hint, required String? value, required List<String> items, required ValueChanged<String?> onChanged, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? () => _showSelectionModal(label, items, value, onChanged) : null,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: enabled ? const Color(0xFFF3F4F6) : const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Row(children: [Icon(Icons.location_on, color: enabled ? const Color(0xFF1E40AF) : const Color(0xFF9CA3AF)), const SizedBox(width: 12), Expanded(child: Text(value ?? hint, style: TextStyle(color: value != null ? const Color(0xFF1E293B) : const Color(0xFF9CA3AF)))), Icon(Icons.arrow_drop_down, color: enabled ? const Color(0xFF64748B) : const Color(0xFF9CA3AF))]),
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
            Container(padding: const EdgeInsets.all(20), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB)))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))])),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = item == currentValue;
                  return ListTile(
                    title: Text(item),
                    trailing: isSelected ? const Icon(Icons.check, color: Color(0xFFE65100)) : null,
                    selected: isSelected,
                    selectedTileColor: const Color(0xFFE65100).withOpacity(0.1),
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

  void _showSportTypeModal(SportConfig sport) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
            Container(padding: const EdgeInsets.all(20), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB)))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Select Sport Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))])),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemCount: _sportOptions.length,
                itemBuilder: (context, index) {
                  final sportOption = _sportOptions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() => sport.type = sportOption['id']);
                      Navigator.pop(context);
                    },
                    child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(sportOption['icon'], size: 32, color: const Color(0xFFE65100)), const SizedBox(height: 8), Text(sportOption['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)))])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCourtLabel(String? sportType) {
    if (sportType == null) return 'Number of Courts';
    const labels = {
      'football': 'Number of Turfs',
      'cricket': 'Number of Turfs',
      'swimming': 'Number of Pools',
      'table_tennis': 'Number of Tables',
      'gym': 'Number of Areas',
    };
    return labels[sportType] ?? 'Number of Courts';
  }

  String _getSingularCourtLabel(String? sportType) {
    if (sportType == null) return 'Court';
    const labels = {
      'football': 'Turf',
      'cricket': 'Turf',
      'swimming': 'Pool',
      'table_tennis': 'Table',
      'gym': 'Area',
    };
    return labels[sportType] ?? 'Court';
  }

  void _handleNext() async {
    if (_currentStep == 0) {
      if (!(_step1FormKey.currentState?.validate() ?? false)) return;
      if (_selectedState == null || _selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select state and city')));
        return;
      }
    } else if (_currentStep == 1) {
      if (_sports.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add at least one sport')));
        return;
      }
    }

    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Facility registered successfully!'), backgroundColor: Color(0xFF10B981)));
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }
}

// DATA MODELS
class SportConfig {
  String? type;
  int totalCourts = 1;
  bool hasDifferentSpecs = false;
  String? surfaceType;
  String? courtSize;
  String openingTime = '06:00';
  String closingTime = '22:00';

  final TextEditingController weekdayPriceController = TextEditingController();
  final TextEditingController weekendPriceController = TextEditingController();
  final TextEditingController customSizeController = TextEditingController();

  List<CourtConfig> courts = [];

  void dispose() {
    weekdayPriceController.dispose();
    weekendPriceController.dispose();
    customSizeController.dispose();
    for (var court in courts) {
      court.dispose();
    }
  }
}

class CourtConfig {
  String name;
  String? surfaceType;
  String? courtSize;

  final TextEditingController weekdayPriceController = TextEditingController();
  final TextEditingController weekendPriceController = TextEditingController();
  final TextEditingController customSizeController = TextEditingController();

  CourtConfig({
    this.name = 'Court A',
    this.surfaceType,
    this.courtSize,
  });

  void dispose() {
    weekdayPriceController.dispose();
    weekendPriceController.dispose();
    customSizeController.dispose();
  }
}