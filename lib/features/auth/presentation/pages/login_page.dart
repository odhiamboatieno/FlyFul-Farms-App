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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 32),
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
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.eco,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Flyful Farms',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Insect Farming Management',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
