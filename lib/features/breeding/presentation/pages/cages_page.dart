import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class CagesPage extends StatelessWidget {
  const CagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 3;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Breeding cages', 'Look after the cages'),
            const SizedBox(height: 16),
            _buildCage('Cage A', '4 days · 3.2 KG pupa', Icons.check_circle, AppColors.green, 'Good', true),
            const SizedBox(height: 9),
            _buildCage('Cage B', '6 days · 2.8 KG pupa', Icons.water_drop, AppColors.orange, 'Water', false),
            const SizedBox(height: 9),
            _buildCage('Cage C', '2 days · 4.0 KG pupa', Icons.check_circle, AppColors.green, 'Good', false),
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

  Widget _buildCage(String name, String details, IconData taskIcon, Color tagColor, String tag, bool hasEggTask) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
            child: Icon(FontAwesomeIcons.warehouse.data, color: AppColors.green, size: 20)),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            OutfitText(text: name, fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
            Text(details, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(color: tagColor == AppColors.orange ? AppColors.orangebg : AppColors.pale, borderRadius: BorderRadius.circular(4)),
            child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: tagColor))),
        ]),
        if (hasEggTask) ...[
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.egg, color: AppColors.green, size: 16),
            const SizedBox(width: 5),
            const Expanded(child: Text('Collect eggs today', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
            const SizedBox(width: 5),
            GestureDetector(onTap: () {}, child: const Icon(Icons.arrow_forward_ios, color: Color(0xFFC8D4CA), size: 16)),
          ]),
        ],
      ]),
    );
  }
}
