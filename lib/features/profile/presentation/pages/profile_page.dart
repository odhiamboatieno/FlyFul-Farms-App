import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final name = _fullName(user?.firstName, user?.lastName) ?? user?.phone ?? 'Farmer';
    final location = _location(user?.village, user?.county);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'My profile', 'Your information'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      _initials(name),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  OutfitText(text: name, fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                  Text('Flyful Farms farmer', style: TextStyle(fontSize: 12, color: Color(0xFFD8F0DF))),
                ])),
              ]),
            ),
            const SizedBox(height: 14),
            _buildSectionHeader('My details'),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.phone, user?.phone ?? 'Not set'),
            const SizedBox(height: 7),
            _buildDetailRow(Icons.alternate_email, user?.email ?? 'No email'),
            const SizedBox(height: 7),
            _buildDetailRow(Icons.location_on, location),
            const SizedBox(height: 14),
            _buildLinkRow(context, Icons.edit_outlined, 'Edit profile', '/edit-profile'),
            const SizedBox(height: 7),
            _buildLinkRow(context, Icons.settings_outlined, 'Settings', '/settings'),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  String? _fullName(String? first, String? last) {
    final f = first?.trim() ?? '';
    final l = last?.trim() ?? '';
    final joined = '$f $l'.trim();
    return joined.isEmpty ? null : joined;
  }

  String _location(String? village, String? county) {
    final v = village?.trim() ?? '';
    final c = county?.trim() ?? '';
    final joined = '$v, $c'.replaceAll(RegExp(r'^,\s*|\s*,\s*$'), '');
    return joined.isEmpty ? 'Not set' : joined;
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 ? parts.last[0] : '';
    return (first + last).toUpperCase();
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

  Widget _buildDetailRow(IconData icon, String text) {
    return Container(
      height: 47,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        SizedBox(width: 47, child: Icon(icon, color: AppColors.green, size: 20)),
        Expanded(child: Text(text, style: TextStyle(fontSize: 15, color: AppColors.ink))),
      ]),
    );
  }

  Widget _buildLinkRow(BuildContext context, IconData icon, String label, String route) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.green, size: 20),
        title: Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFFC8D4CA), size: 18),
        onTap: () => Navigator.pushNamed(context, route),
        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
      ),
    );
  }
}
