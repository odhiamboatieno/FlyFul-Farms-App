import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class CageDetailPage extends StatelessWidget {
  const CageDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Cage A', 'Breeding details'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                OutfitText(text: 'Egg collection', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink),
                const SizedBox(height: 8),
                Text('Last collected: Today', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ]),
            ),
          ]),
        ),
      ),
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
}
