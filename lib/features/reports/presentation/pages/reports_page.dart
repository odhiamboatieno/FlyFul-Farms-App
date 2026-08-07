import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

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
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
              child: Column(children: [
                Row(children: [
                  Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(7)),
                    child: const Icon(Icons.eco, color: AppColors.green, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    OutfitText(text: 'Your farm is growing', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    Text('You harvested more larvae this week.', style: TextStyle(fontSize: 12, color: Color(0xFF54735D))),
                  ])),
                ]),
              ]),
            ),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _buildPeriodButton('This week', isSelected: true)),
              const SizedBox(width: 7),
              Expanded(child: _buildPeriodButton('Last week')),
            ]),
            const SizedBox(height: 10),
            const Text('Tall green bar means more than last week.', style: TextStyle(fontSize: 11, color: Color(0xFF9AA69E))),
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

  Widget _buildPeriodButton(String label, {bool isSelected = false}) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.green : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : AppColors.muted,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: AppColors.line)),
      ),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }
}
