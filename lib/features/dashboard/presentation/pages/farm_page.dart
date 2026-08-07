import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class FarmPage extends StatefulWidget {
  const FarmPage({super.key});

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'My farm', 'See your farm this week'),
            const SizedBox(height: 16),
            _buildFarmHero(),
            const SizedBox(height: 20),
            OutfitText(text: 'What you have', fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.ink, letterSpacing: -0.015),
            const SizedBox(height: 10),
            _buildFarmStats(),
            _buildFarmLinks(),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
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

  Widget _buildFarmHero() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF145A38), Color(0xFF2C8A54)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('THIS WEEK', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFD8F0DF), letterSpacing: 0.04)),
        const SizedBox(height: 5),
        const OutfitText(text: 'Your farm is growing', fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.02),
        const SizedBox(height: 5),
        const Text('You harvested more larvae than last week.', style: TextStyle(fontSize: 14, color: Color(0xFFE3F3E7))),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/compare'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.11), foregroundColor: Colors.white, padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('See farm results', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 16),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildFarmStats() {
    return Column(children: [
      _buildStatRow(Icons.eco, '101 KG', 'Larvae'),
      const SizedBox(height: 7),
      _buildStatRow(Icons.eco, '76 KG', 'Frass', isFrass: true),
      const SizedBox(height: 7),
      _buildStatRow(Icons.egg, '48 G', 'Eggs', isEgg: true),
      const SizedBox(height: 7),
      _buildStatRow(Icons.circle, '8.7 KG', 'Pupa'),
    ]);
  }

  Widget _buildStatRow(IconData icon, String value, String label, {bool isFrass = false, bool isEgg = false}) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/stock'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Container(
        height: 118,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(icon, color: AppColors.green, size: 24),
          OutfitText(text: value, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ]),
      ),
    );
  }

  Widget _buildFarmLinks() {
    return Column(children: [
      _buildFarmLink(Icons.layers, 'My batches', '/batches'),
      const SizedBox(height: 7),
      _buildFarmLink(Icons.warehouse, 'Breeding cages', '/cages'),
    ]);
  }

  Widget _buildFarmLink(IconData icon, String label, String route) {
    return Container(
      height: 47,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Row(children: [
          Icon(icon, color: AppColors.green, size: 24),
          const SizedBox(width: 11),
          Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
        ]),
      ),
    );
  }
}
