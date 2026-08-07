import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Farm growth', 'See this week and last week'),
            const SizedBox(height: 16),
            _buildGrowthHero(),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _buildPeriodButton('This week', isSelected: true)),
              const SizedBox(width: 7),
              Expanded(child: _buildPeriodButton('Last week')),
            ]),
            const SizedBox(height: 10),
            const Text('Tall green bar means more than last week.', style: TextStyle(fontSize: 11, color: Color(0xFF9AA69E))),
            const SizedBox(height: 14),
            _buildCompareCard(Icons.eco, 'Waste used', 'Food given to larvae', '286', 'KG', 0.86, '244'),
            _buildCompareCard(Icons.eco, 'Larvae harvested', 'Larvae ready for sale', '101', 'KG', 0.78, '86'),
            _buildCompareCard(Icons.eco, 'Frass collected', 'Fertilizer from the farm', '76', 'KG', null, null, isFrass: true),
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

  Widget _buildGrowthHero() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.greenBg,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.orangebg),
      ),
      child: Row(children: [
        Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(7)),
          child: const Icon(Icons.eco, color: Colors.white, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const OutfitText(text: 'Your farm is growing', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.green),
          Text('You harvested more larvae this week.', style: TextStyle(fontSize: 12, color: Color(0xFF54735D))),
        ])),
      ]),
    );
  }

  Widget _buildPeriodButton(String label, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.green : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : AppColors.muted,
        padding: const EdgeInsets.symmetric(vertical: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildCompareCard(IconData icon, String title, String subtitle, String value, String unit, double? thisWeekPercent, String? lastWeek, {bool isFrass = false}) {
    return Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 3, offset: const Offset(0, 1))],
      ),
      child: Column(children: [
        Row(children: [
          Container(width: 39, height: 39, decoration: BoxDecoration(color: isFrass ? AppColors.blueBg : AppColors.orangebg, borderRadius: BorderRadius.circular(7)),
            child: Icon(icon, color: isFrass ? AppColors.blue : AppColors.orange, size: 22)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            OutfitText(text: title, fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink),
            Text(subtitle, style: TextStyle(fontSize: 10, color: AppColors.muted)),
          ])),
          OutfitText(text: '$value $unit', fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink),
        ]),
        const SizedBox(height: 13),
        if (thisWeekPercent != null) ...[
          _buildBarRow('This week', thisWeekPercent, value),
          const SizedBox(height: 6),
          _buildBarRow('Last week', lastWeek != null ? double.parse(lastWeek) / double.parse(value) : 0.66, lastWeek ?? ''),
        ],
        if (isFrass) ...[
          Container(
            height: 40, width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF8FBF8), borderRadius: BorderRadius.circular(5)),
            child: const Center(child: Text('No improvement — farm stable this week', style: TextStyle(fontSize: 11, color: Color(0xFF9AA69E)))),
          ),
        ],
      ]),
    );
  }

  Widget _buildBarRow(String label, double percent, String value) {
    final bool isLastWeek = label == 'Last week';
    return Row(children: [
      SizedBox(
        width: 63,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isLastWeek ? AppColors.muted : AppColors.green,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 9,
          decoration: BoxDecoration(
            color: const Color(0xFFE4EFE6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: percent * 100,
              height: 9,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 6),
      Text(
        value,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.ink),
      ),
    ]);
  }
}
