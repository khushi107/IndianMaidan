// // lib/screen/business/business_services_screen.dart
// import 'package:flutter/material.dart';
// import 'turf_registration_screen.dart';

// class BusinessServicesScreen extends StatelessWidget {
//   const BusinessServicesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF1F5F9),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header Section
//             _buildHeader(context),
            
//             // Main Content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   children: [
//                     // Section heading
//                     const Text(
//                       'Choose your sports solution',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1E293B),
//                       ),
//                     ),
                    
//                     const SizedBox(height: 24),
                    
//                     // Available Service - Turf Registration
//                     _buildAvailableServiceCard(context),
                    
//                     const SizedBox(height: 16),
                    
//                     // Coming Soon Services
//                     _buildComingSoonCard(
//                       icon: Icons.school_outlined,
//                       title: 'Academy Registration',
//                       subtitle: 'Sports Academy & Coaching',
//                       color: const Color(0xFF8B5CF6),
//                     ),
                    
//                     const SizedBox(height: 16),
                    
//                     _buildComingSoonCard(
//                       icon: Icons.emoji_events_outlined,
//                       title: 'Tournament Hosting',
//                       subtitle: 'Organize Sports Events',
//                       color: const Color(0xFFEAB308),
//                     ),
                    
//                     const SizedBox(height: 16),
                    
//                     _buildComingSoonCard(
//                       icon: Icons.sports_outlined,
//                       title: 'Coach Registration',
//                       subtitle: 'Professional Sports Coaching',
//                       color: const Color(0xFF06B6D4),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               // Back button
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: const Color(0xFFE5E7EB)),
//                 ),
//                 child: IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
//                 ),
//               ),
              
//               const SizedBox(width: 16),
              
//               // Title section
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Available Services',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B),
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       'Select your business category',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF64748B),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAvailableServiceCard(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const TurfRegistrationScreen(),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFFE65100), Color(0xFFFF6F00)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFE65100).withOpacity(0.3),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(
//                 Icons.sports_soccer,
//                 color: Colors.white,
//                 size: 32,
//               ),
//             ),
            
//             const SizedBox(width: 16),
            
//             // Text content
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Turf Registration',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Sports Ground & Facility',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Action button
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Register Now',
//                     style: TextStyle(
//                       color: Color(0xFFE65100),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(width: 4),
//                   Icon(
//                     Icons.arrow_forward,
//                     color: Color(0xFFE65100),
//                     size: 16,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildComingSoonCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E7EB)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Opacity(
//         opacity: 0.6,
//         child: Row(
//           children: [
//             // Icon
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: color,
//                 size: 32,
//               ),
//             ),
            
//             const SizedBox(width: 16),
            
//             // Text content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Color(0xFF1E293B),
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       color: Color(0xFF64748B),
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Coming Soon badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF64748B).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.access_time,
//                     color: Color(0xFF64748B),
//                     size: 14,
//                   ),
//                   SizedBox(width: 4),
//                   Text(
//                     'Coming Soon',
//                     style: TextStyle(
//                       color: Color(0xFF64748B),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/screen/business/business_services_screen.dart
import 'package:flutter/material.dart';
import 'turf_registration_screen.dart';

class BusinessServicesScreen extends StatelessWidget {
  const BusinessServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Section heading
                    const Text(
                      'Choose your sports solution',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Available Service - Turf Registration
                    _buildAvailableServiceCard(context),
                    
                    const SizedBox(height: 16),
                    
                    // Coming Soon Services
                    _buildComingSoonCard(
                      icon: Icons.school_outlined,
                      title: 'Academy Registration',
                      subtitle: 'Sports Academy & Coaching',
                      color: const Color(0xFF8B5CF6),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildComingSoonCard(
                      icon: Icons.emoji_events_outlined,
                      title: 'Tournament Hosting',
                      subtitle: 'Organize Sports Events',
                      color: const Color(0xFFEAB308),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildComingSoonCard(
                      icon: Icons.sports_outlined,
                      title: 'Coach Registration',
                      subtitle: 'Professional Sports Coaching',
                      color: const Color(0xFF06B6D4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE65100), width: 2), // Added orange border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Back button
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
              
              // Title section - Made flexible
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Services',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Select your business category',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableServiceCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TurfRegistrationScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE65100), Color(0xFFFF6F00)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE65100).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Text content - Made flexible
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Turf Registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Sports Ground & Facility',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action button - Full width
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Register Now',
                    style: TextStyle(
                      color: Color(0xFFE65100),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFE65100),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComingSoonCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Opacity(
        opacity: 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 32,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Text content - Made flexible
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Coming Soon badge - Full width
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF64748B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Color(0xFF64748B),
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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