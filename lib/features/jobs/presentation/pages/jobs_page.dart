import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                title: 'Feed Batch 012',
                subtitle: 'Do this first',
                trailing: Icons.arrow_forward_ios,
                onTap: () => Navigator.pushNamed(context, '/feed-type'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.water_drop,
                iconBg: AppColors.orangebg,
                iconColor: AppColors.orange,
                title: 'Add water · Cage B',
                subtitle: 'Do after feeding',
                trailing: Icons.arrow_forward_ios,
                onTap: () => Navigator.pushNamed(context, '/cages'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.balance,
                iconBg: AppColors.pale,
                iconColor: AppColors.orange,
                title: 'Harvest Batch 007',
                subtitle: 'Ready today',
                trailing: Icons.arrow_forward_ios,
                isUrgent: true,
                onTap: () => Navigator.pushNamed(context, '/harvest-larvae'),
              ),
              const SizedBox(height: 9),
              _buildTask(
                icon: Icons.egg,
                iconBg: AppColors.pale,
                iconColor: AppColors.green,
                title: 'Collect eggs · Cage A',
                subtitle: 'Do last',
                trailing: Icons.arrow_forward_ios,
                onTap: () => Navigator.pushNamed(context, '/eggs'),
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
          onTap: () => Navigator.pop(context),
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
