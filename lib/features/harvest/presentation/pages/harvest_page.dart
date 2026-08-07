import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class HarvestPage extends StatelessWidget {
  const HarvestPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Harvest', 'Batch 007'),
            const SizedBox(height: 16),
            _buildStatCard(Icons.water, 'Water used', '12.5 L', Icons.water_drop),
            const SizedBox(height: 9),
            _buildStatCard(Icons.eco, 'Larvae sold', '52 KG', Icons.eco),
            const SizedBox(height: 9),
            _buildStatCard(Icons.eco, 'Frass sold', '18.7 KG', Icons.eco),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: currentIndex, onTap: (i) => currentIndex = i),
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

  Widget _buildStatCard(IconData icon, String label, String value, IconData valueIcon) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Container(width: 43, height: 43, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, color: AppColors.green, size: 24)),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: value, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Icon(valueIcon, color: AppColors.green, size: 20),
      ]),
    );
  }
}
