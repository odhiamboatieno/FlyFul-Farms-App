import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/reports/presentation/providers/compare_provider.dart';
import 'package:provider/provider.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});

  @override
  Widget build(BuildContext context) {
    final compare = context.watch<CompareProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Farm growth', 'See this week and last week'),
            const SizedBox(height: 16),
            _buildGrowthHero(compare),
            const SizedBox(height: 14),
            const Text('Green bar = this week, grey label = last week.', style: TextStyle(fontSize: 11, color: Color(0xFF9AA69E))),
            const SizedBox(height: 14),
            _buildCompareCard(Icons.eco, 'Waste used', 'Food given to larvae', compare.wasteUsed),
            _buildCompareCard(Icons.eco, 'Larvae harvested', 'Larvae ready for sale', compare.larvaeHarvested),
            _buildCompareCard(Icons.eco, 'Frass collected', 'Fertilizer from the farm', compare.frassCollected, isFrass: true),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }

  Widget _buildGrowthHero(CompareProvider compare) {
    final improved = compare.overallImproved;
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
          OutfitText(
            text: improved ? 'Your farm is growing' : 'Your farm this week',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.green,
          ),
          Text(
            compare.larvaeHarvested.thisWeek == 0 && compare.larvaeHarvested.lastWeek == 0
                ? 'Add your first harvest to see growth.'
                : improved
                    ? 'You harvested more larvae this week.'
                    : 'Slightly less larvae this week.',
            style: TextStyle(fontSize: 12, color: Color(0xFF54735D)),
          ),
        ])),
      ]),
    );
  }

  Widget _buildCompareCard(IconData icon, String title, String subtitle, WeekStat stat, {bool isFrass = false}) {
    final bothZero = stat.thisWeek == 0 && stat.lastWeek == 0;
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
          OutfitText(text: stat.formatKg(), fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink),
        ]),
        const SizedBox(height: 13),
        if (!bothZero) ...[
          _buildBarRow('This week', stat.percentThisWeek, stat.formatKg()),
          const SizedBox(height: 6),
          _buildBarRow('Last week', stat.percentLastWeek, stat.formatLastKg()),
        ] else
          Container(
            height: 40, width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFF8FBF8), borderRadius: BorderRadius.circular(5)),
            child: const Center(child: Text('No records yet this week or last week', style: TextStyle(fontSize: 11, color: Color(0xFF9AA69E)))),
          ),
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
