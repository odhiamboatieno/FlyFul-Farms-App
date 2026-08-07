import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/auth/presentation/widgets/auth_form.dart';
import 'package:go_router/go_router.dart';

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
                  onLogin: () {
                    context.go('/dashboard');
                  },
                  onRegister: () {
                    context.go('/register');
                  },
                  onForgotPassword: () {
                    context.go('/forgot-password');
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/forgot-password'),
                  child: const Text('Forgot your password?'),
                ),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text("Don't have an account? Register"),
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
