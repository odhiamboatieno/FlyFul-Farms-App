import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/farm_provider.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/today_provider.dart';
import 'package:flyful_farms/features/reports/presentation/providers/compare_provider.dart';
import 'package:go_router/go_router.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshDashboards();
    });
  }

  Future<void> _refreshDashboards() async {
    await getIt<TodayProvider>().load();
    await getIt<FarmProvider>().load();
    await getIt<CompareProvider>().load();
    await getIt<BatchProvider>().loadBatches();
    await getIt<CageProvider>().loadCages();
  }

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
