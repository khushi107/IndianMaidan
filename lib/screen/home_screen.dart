import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Timer _countdownTimer;
  
  int selectedCategoryIndex = 0;
  Duration countdownDuration = Duration(hours: 3, minutes: 45, seconds: 30);
  
  final List<String> categories = [
    'All Sports',
    'Cricket',
    'Football',
    'Badminton'
  ];
  
  final List<IconData> categoryIcons = [
    Icons.sports,
    Icons.sports_baseball,
    Icons.sports_soccer,
    Icons.sports_tennis
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize scale animation for Explore Turfs button
    _scaleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
    
    _scaleController.repeat(reverse: true);
    
    // Initialize countdown timer
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownDuration.inSeconds > 0) {
          countdownDuration = Duration(seconds: countdownDuration.inSeconds - 1);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _countdownTimer.cancel();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _formatCountdown(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    return '$days:${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    _buildSearchBar(),
                    SizedBox(height: 24),
                    
                    // Quick Actions Section
                    _buildQuickActions(),
                    SizedBox(height: 24),
                    
                    // Upcoming Booking Card
                    _buildUpcomingBooking(),
                    SizedBox(height: 24),
                    
                    // Sports Categories
                    _buildSportsCategories(),
                    SizedBox(height: 20),
                    
                    // Featured Turfs
                    _buildFeaturedTurfs(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8FAFC),
            Color(0xFFF1F5F9),
            Color(0xFFE2E8F0),
          ],
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Darshan',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Sporty',
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Color(0xFFE65100),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bhilwara, Rajasthan',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Notification Button
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    // Handle notification tap
                  },
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF1E293B),
                    size: 24,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Profile Button
          GestureDetector(
            onTap: () {
              // Handle profile tap
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFE65100),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'D',
                  style: TextStyle(
                    color: Color(0xFFE65100),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.search,
              color: Color(0xFF64748B),
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              'Search turfs, sports, locations...',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle filter tap
            },
            icon: Icon(
              Icons.tune,
              color: Color(0xFF64748B),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: () {
              // Handle explore turfs tap
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE65100),
                    Color(0xFFFF6F00),
                    Color(0xFFFF8F00),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE65100).withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore Turfs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sporty',
                          ),
                        ),
                        Text(
                          'Find perfect venues nearby',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpcomingBooking() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elite Football Arena',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.sports_soccer,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Today • 6:00 PM',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Confirmed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Countdown Timer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE65100), Color(0xFFFF6F00)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Remaining:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _formatCountdown(countdownDuration),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Handle view details
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle get directions
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE65100),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(Icons.directions, size: 16, color: Colors.white),
                  label: Text(
                    'Get Directions',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSportsCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sports Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isSelected = selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        categoryIcons[index],
                        size: 16,
                        color: isSelected ? Colors.white : Color(0xFF64748B),
                      ),
                      SizedBox(width: 6),
                      Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedTurfs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Turfs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _buildTurfCard(index);
          },
        ),
      ],
    );
  }

  Widget _buildTurfCard(int index) {
    final turfNames = [
      'Elite Football Arena',
      'Champions Cricket Ground',
      'Victory Sports Complex'
    ];
    
    final prices = ['₹500', '₹350', '₹600'];
    final distances = ['1.2 km', '0.8 km', '2.1 km'];

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.sports_soccer,
                    size: 60,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              
              // Sport Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE65100), Color(0xFFFF6F00)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Football',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              // See on Map & Distance
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.map,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        distances[index],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Price Tag
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${prices[index]}/hr',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content Section
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        turfNames[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: Color(0xFF10B981),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Available for booking',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bhilwara, Rajasthan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '6:00 AM - 11:00 PM',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                // Book Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle book now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE65100),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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


}