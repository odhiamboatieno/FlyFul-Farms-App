import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/reports/presentation/providers/compare_provider.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool _showThisWeek = true;

  @override
  Widget build(BuildContext context) {
    final compare = context.watch<CompareProvider>();
    final improved = compare.overallImproved;

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
              child: Row(children: [
                Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(7)),
                  child: const Icon(Icons.eco, color: AppColors.green, size: 22)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  OutfitText(text: improved ? 'Your farm is growing' : 'Your farm this week', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
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
            ),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _buildPeriodButton('This week', isSelected: _showThisWeek, onTap: () => setState(() => _showThisWeek = true))),
              const SizedBox(width: 7),
              Expanded(child: _buildPeriodButton('Last week', isSelected: !_showThisWeek, onTap: () => setState(() => _showThisWeek = false))),
            ]),
            const SizedBox(height: 10),
            if (compare.loading)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator(color: AppColors.green)),
              )
            else ...[
              _buildStatRow(Icons.water_drop, 'Waste used', _stat(compare.wasteUsed)),
              const SizedBox(height: 9),
              _buildStatRow(Icons.balance, 'Larvae harvested', _stat(compare.larvaeHarvested)),
              const SizedBox(height: 9),
              _buildStatRow(Icons.eco, 'Frass collected', _stat(compare.frassCollected)),
              const SizedBox(height: 12),
              Text(
                _showThisWeek ? 'This week, compared with last week.' : 'Last week, compared with this week.',
                style: const TextStyle(fontSize: 11, color: Color(0xFF9AA69E)),
              ),
            ],
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  String _stat(WeekStat stat) {
    final current = _showThisWeek ? stat.thisWeek : stat.lastWeek;
    final other = _showThisWeek ? stat.lastWeek : stat.thisWeek;
    final improved = current >= other && other > 0;
    final direction = current == 0 && other == 0
        ? 'No records yet'
        : '${improved ? 'Up' : 'Down'} from ${other.toStringAsFixed(1)} KG';
    return '${current.toStringAsFixed(1)} KG · $direction';
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

  Widget _buildPeriodButton(String label, {required bool isSelected, required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.green : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : AppColors.muted,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: AppColors.line)),
      ),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Container(width: 43, height: 43, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, color: AppColors.green, size: 22)),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: value, fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
      ]),
    );
  }
}
