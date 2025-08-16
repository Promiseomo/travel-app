
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmark_provider.dart';


class MiamiScreen extends StatelessWidget {
  const MiamiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Miami, USA')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Beach Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1530686577637-0ccce382b327',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Miami-specific content
            const Text(
              'Miami blends tropical beauty with urban energy, famous for its Art Deco architecture, Cuban influences, and vibrant nightlife.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            
            const SizedBox(height: 20),
            
            // Miami sections
            _buildSection('Must-Visit Beaches', [
              'South Beach - Iconic art deco backdrop',
              'Key Biscayne - Pristine and family-friendly',
              'Bal Harbour - Luxury beach experience'
            ]),
            
            _buildSection('Cultural Hotspots', [
              'Little Havana - Cuban culture and cuisine',
              'Wynwood Walls - Street art paradise',
              'Vizcaya Museum - European-style villa'
            ]),
            
            const SizedBox(height: 30), // Space before button
            
            // Book Now Button - ADDED HERE (outside _buildSection)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking for Miami confirmed!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Miami-style pink color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'BOOK NOW',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This remains unchanged - just builds sections
  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.arrow_right, color: Colors.pink),
              const SizedBox(width: 8),
              Text(item),
            ],
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}