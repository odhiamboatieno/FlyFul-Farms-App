import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class BatchDetailPage extends StatelessWidget {
  final String id;
  const BatchDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Batch $id', 'Vegetables · Day 3'),
            const SizedBox(height: 16),
            _buildStatCard('Larvae', '5.2 KG', Icons.eco),
            const SizedBox(height: 9),
            _buildStatCard('Frass', '1.8 KG', Icons.recycling),
            const SizedBox(height: 9),
            _buildStatCard('Feeding', '12.0 KG', Icons.food_bank),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon, color: AppColors.green, size: 24),
        Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink)),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
      ]),
    );
  }
}
