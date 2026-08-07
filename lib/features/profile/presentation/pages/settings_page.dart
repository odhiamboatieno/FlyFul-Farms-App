import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPageHeader(context, 'Settings', 'Make the app easy for you'),
              const SizedBox(height: 16),
              _buildNavItem(Icons.language, 'English', 'Language', onTap: () {}),
              _buildNavItem(Icons.volume_up, 'Reminder sound', '',
                  trailing: Icon(Icons.toggle_on, size: 22, color: AppColors.green), onTap: () {}),
              _buildNavItem(Icons.dark_mode, 'Dark mode', '',
                  trailing: Icon(Icons.toggle_off, size: 22, color: AppColors.muted), onTap: () {}),
            ],
          ),
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

  Widget _buildNavItem(IconData icon, String value, String subvalue,
      {Widget? trailing, VoidCallback? onTap}) {
    return Container(
      height: 47,
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.green, size: 20),
        title: Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
        subtitle: subvalue.isNotEmpty ? Text(subvalue, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)) : null,
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Color(0xFFC8D4CA), size: 18),
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
      ),
    );
  }
}
