import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/features/auth/presentation/widgets/auth_form.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                isLogin: true,
                onSubmit: (phone, email, password, pin, name) {
                  return context.read<AuthProvider>().login(
                        phone: phone,
                        email: email.isEmpty ? null : email,
                        password: password.isEmpty ? null : password,
                        pin: pin.isEmpty ? null : pin,
                      );
                },
                onSwitchMode: () => context.go('/register'),
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
        OutfitText(text: 'Welcome back', fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text('Log in to your farm', style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
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
      Text('Insect Farming Management',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
    ]);
  }
}
