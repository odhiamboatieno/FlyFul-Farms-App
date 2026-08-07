import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Edit profile', 'Update your information'),
            const SizedBox(height: 16),
            Center(child: Container(width: 80, height: 80, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.person, color: Colors.white, size: 44))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Full name')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Phone number'), keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('SAVE')),
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
}
