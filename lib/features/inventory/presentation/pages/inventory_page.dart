import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Inventory', 'Stock levels'),
            const SizedBox(height: 16),
            _buildStockCard(Icons.eco, 'Larvae', '84 KG'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.egg, 'Eggs', '48 G'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.circle, 'Pupa', '8.7 KG'),
            const SizedBox(height: 9),
            _buildStockCard(Icons.eco, 'Frass', '62 KG'),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
      Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
    ]);
  }

  Widget _buildStockCard(IconData icon, String label, String value) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(width: 43, height: 43, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, color: AppColors.green, size: 22)),
        const SizedBox(width: 11),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          OutfitText(text: value, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
      ]),
    );
  }
}
