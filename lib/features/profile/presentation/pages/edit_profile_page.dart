import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _villageController;
  late final TextEditingController _countyController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _villageController = TextEditingController(text: user?.village ?? '');
    _countyController = TextEditingController(text: user?.county ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _villageController.dispose();
    _countyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final auth = context.read<AuthProvider>();
    final ok = await auth.updateProfile(
      firstName: _firstNameController.text.trim().isEmpty
          ? null
          : _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim().isEmpty
          ? null
          : _lastNameController.text.trim(),
      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      village: _villageController.text.trim().isEmpty
          ? null
          : _villageController.text.trim(),
      county: _countyController.text.trim().isEmpty
          ? null
          : _countyController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _saving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Profile updated' : (auth.errorMessage ?? 'Update failed')),
      ),
    );

    if (ok) {
      context.pop();
    }
  }

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
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First name'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last name'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _villageController,
              decoration: const InputDecoration(labelText: 'Village'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _countyController,
              decoration: const InputDecoration(labelText: 'County'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('SAVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
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
}
