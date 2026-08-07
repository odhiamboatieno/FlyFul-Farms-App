import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Farm stock', 'What you have now'),
            const SizedBox(height: 16),
            _buildStockCard(Icons.eco, '84 KG', 'Larvae'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.egg, '48 G', 'Eggs'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.circle, '8.7 KG', 'Pupa'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.eco, '62 KG', 'Frass'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.recycling, '120 KG', 'Waste ready'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.layers, '6', 'Live batches'),
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
