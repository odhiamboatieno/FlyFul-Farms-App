import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:go_router/go_router.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.check, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 18),
              OutfitText(text: 'Saved well', fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.green),
              const SizedBox(height: 8),
              Text(
                'Your farm record is safe on this phone. It will sync when internet is available.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/today'),
                  child: const Text('Back to today'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
