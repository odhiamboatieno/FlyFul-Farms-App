import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _confirmLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: AppColors.orangebg),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 17),
                    SizedBox(width: 7),
                    Text('Log out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('Your work stays on this phone and will sync when you log back in.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<AuthProvider>().logout();
    }
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
