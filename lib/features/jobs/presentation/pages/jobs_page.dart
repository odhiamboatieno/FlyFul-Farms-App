import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final batches = context.watch<BatchProvider>().batches;
    final cages = context.watch<CageProvider>().cages;

    final activeBatches = batches.where((b) => b.status == 'active').toList();
    final activeCages = cages.where((c) => c.status == 'active').toList();

    final feedBatch = activeBatches.isNotEmpty ? activeBatches.first.batchNumber : null;
    final harvestBatch = activeBatches.length > 1 ? activeBatches.last.batchNumber : feedBatch;

    BreedingCage? waterCage;
    if (activeCages.isNotEmpty) {
      waterCage = activeCages.firstWhere((c) => !c.waterAdded, orElse: () => activeCages.first);
    } else if (cages.isNotEmpty) {
      waterCage = cages.first;
    }
    final waterCageName = waterCage?.cageNumber;

    final eggCage = activeCages.isNotEmpty ? activeCages.first : (cages.isNotEmpty ? cages.first : null);
    final eggCageName = eggCage?.cageNumber;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPageHeader(
                context,
                title: 'Today’s jobs',
                subtitle: 'Do them one at a time',
              ),
              const SizedBox(height: 22),
              _buildTask(
                icon: FontAwesomeIcons.bowlFood.data,
                iconBg: AppColors.pale,
                iconColor: AppColors.green,
                title: feedBatch == null ? 'No batch to feed' : 'Feed Batch $feedBatch',
                subtitle: feedBatch == null ? 'Create a batch first' : 'Log feeding for this batch',
                trailing: Icons.arrow_forward_ios,
                onTap: () => context.push('/feed-type'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.water_drop,
                iconBg: AppColors.orangebg,
                iconColor: AppColors.orange,
                title: waterCageName == null ? 'No cage yet' : 'Add water · Cage $waterCageName',
                subtitle: waterCageName == null ? 'Create a cage first' : 'Cages need fresh water daily',
                trailing: Icons.arrow_forward_ios,
                onTap: () => context.push('/maintenance'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.balance,
                iconBg: AppColors.pale,
                iconColor: AppColors.orange,
                title: harvestBatch == null ? 'No batch to harvest' : 'Harvest Batch $harvestBatch',
                subtitle: harvestBatch == null ? 'Create a batch first' : 'Log larvae, frass and pupa',
                trailing: Icons.arrow_forward_ios,
                isUrgent: true,
                onTap: () => context.push('/harvest-larvae'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.egg,
                iconBg: AppColors.pale,
                iconColor: AppColors.green,
                title: eggCageName == null ? 'No cage yet' : 'Collect eggs · Cage $eggCageName',
                subtitle: eggCageName == null ? 'Create a cage first' : 'Weigh today’s eggs',
                trailing: Icons.arrow_forward_ios,
                onTap: () => context.push('/eggs'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildPageHeader(BuildContext context, {required String title, required String subtitle}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutfitText(
              text: title,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTask({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required IconData trailing,
    required VoidCallback onTap,
    bool isUrgent = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: AppColors.ink,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(trailing, color: isUrgent ? AppColors.red : AppColors.muted, size: 16),
          ],
        ),
      ),
    );
  }
}
