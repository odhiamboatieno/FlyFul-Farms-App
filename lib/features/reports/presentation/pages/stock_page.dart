import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/farm_provider.dart';
import 'package:provider/provider.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final farm = context.watch<FarmProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Farm stock', 'What you have now'),
            const SizedBox(height: 16),
            _buildStockCard(Icons.eco, _formatKg(farm.larvaeKg), 'Larvae'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.egg, _formatGrams(farm.eggGrams), 'Eggs'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.circle, _formatKg(farm.pupaKg), 'Pupa'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.eco, _formatKg(farm.frassKg), 'Frass'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.layers, '${farm.batchCount}', 'Live batches'),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  String _formatKg(double value) {
    return value == value.roundToDouble() ? '${value.round()} KG' : '${value.toStringAsFixed(1)} KG';
  }

  String _formatGrams(double value) {
    return '${value.round()} G';
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

  Widget _buildStockCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Icon(icon, color: AppColors.green, size: 24),
        const SizedBox(width: 11),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: value, fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ]),
      ]),
    );
  }
}
