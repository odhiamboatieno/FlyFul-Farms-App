import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Offline & sync', 'Your work is safe'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greenBg,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.orangebg),
              ),
              child: Row(children: [
                Container(width: 43, height: 43, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(7)),
                  child: const Icon(Icons.cloud_upload, color: Colors.white, size: 19)),
                const SizedBox(width: 11),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('3 records waiting', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.green)),
                  Text('They will send when internet returns.', style: TextStyle(fontSize: 11, color: Color(0xFF5B7C64))),
                ])),
              ]),
            ),
            const SizedBox(height: 14),
            _buildSectionHeader('Waiting to send'),
            _buildSyncItem(Icons.food_bank, 'Feeding batch 014', 'Saved today', 'Wait', AppColors.orange),
            const SizedBox(height: 7),
            _buildSyncItem(Icons.egg, 'Eggs · Cage C', 'Saved yesterday', 'Wait', AppColors.orange),
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

  Widget _buildSectionHeader(String title) {
    return Align(alignment: Alignment.centerLeft, child: OutfitText(text: title, fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.ink));
  }

  Widget _buildSyncItem(IconData icon, String title, String subtitle, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, color: AppColors.green, size: 16)),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
          Text(subtitle, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(color: status == 'Wait' ? AppColors.orangebg : AppColors.pale, borderRadius: BorderRadius.circular(4)),
          child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: statusColor))),
      ]),
    );
  }
}
