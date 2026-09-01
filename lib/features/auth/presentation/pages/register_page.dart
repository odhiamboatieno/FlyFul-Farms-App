import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/features/auth/presentation/widgets/auth_form.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              _buildHeader(),
              const SizedBox(height: 24),
              _buildBrand(),
              const SizedBox(height: 28),
              AuthForm(
                isLogin: false,
                onSubmit: (phone, email, password, pin, name) async {
                  final provider = context.read<AuthProvider>();
                  final ok = await provider.register(
                    name: name,
                    phone: phone,
                    email: email.isEmpty ? null : email,
                    password: password.isEmpty ? null : password,
                    pin: pin.isEmpty ? null : pin,
                  );
                  return ok;
                },
                onSwitchMode: () => context.go('/login'),
                onForgotPassword: () {
                  context.go('/forgot-password');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(children: [
      GestureDetector(onTap: () => context.go('/'), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: 'Create account', fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text('Join Flyful Farms today', style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }

  Widget _buildBrand() {
    return Column(children: [
      Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.eco, size: 44, color: Colors.white),
      ),
      const SizedBox(height: 12),
      OutfitText(text: 'Flyful Farms', fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.green, letterSpacing: -0.02),
      const SizedBox(height: 4),
      Text('Start managing your farm',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
    ]);
  }
}
