import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Add record', 'What did you do?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoice(context, Icons.food_bank, 'Fed larvae', '/feed-type'),
                _buildChoice(context, Icons.balance, 'Harvested', '/harvest-larvae'),
                _buildChoice(context, Icons.egg, 'Collected eggs', '/eggs'),
                _buildChoice(context, Icons.water_drop, 'Worked on cage', '/maintenance'),
                _buildChoice(context, Icons.inventory_2_outlined, 'Start a batch', '/batches/new'),
                _buildChoice(context, Icons.warehouse_outlined, 'Add a cage', '/cages/new'),
              ],
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
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

  Widget _buildChoice(BuildContext context, IconData icon, String label, String route) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 34 - 8) / 2,
      child: ElevatedButton(
        onPressed: () => context.push(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, color: AppColors.green, size: 19)),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
        ]),
      ),
    );
  }
}
