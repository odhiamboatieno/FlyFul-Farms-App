import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'My profile', 'Your information'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(children: [
                const Icon(Icons.person, color: Colors.white, size: 44),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  OutfitText(text: 'Amina Kamau', fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                  Text('Flyful Farms farmer', style: TextStyle(fontSize: 12, color: Color(0xFFD8F0DF))),
                ])),
              ]),
            ),
            const SizedBox(height: 14),
            _buildSectionHeader('My details'),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.phone, '0712 345 678'),
            const SizedBox(height: 7),
            _buildDetailRow(Icons.location_on, 'Githunguri, Kiambu'),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }

  Widget _buildSectionHeader(String title) {
    return Align(alignment: Alignment.centerLeft, child: OutfitText(text: title, fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.ink));
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Container(
      height: 47,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        SizedBox(width: 47, child: Icon(icon, color: AppColors.green, size: 20)),
        Expanded(child: Text(text, style: TextStyle(fontSize: 15, color: AppColors.ink))),
      ]),
    );
  }
}
