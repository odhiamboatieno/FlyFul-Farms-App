import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  int _currentIndex = 0;

  void _handleNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 22),
                _buildDailyPlan(),
                const SizedBox(height: 22),
                _buildAddFarmWork(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, onTap: _handleNavTap),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OutfitText(
              text: 'Hello, Amina',
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.015,
            ),
            const SizedBox(height: 3),
            Text(
              'Friday · work for today',
              style: TextStyle(
                fontSize: 14,
                height: 1.3,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(Icons.notifications, color: AppColors.ink, size: 21),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.green, AppColors.green2],
                    transform: GradientRotation(135 * 3.14159 / 180),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    'AK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const OutfitText(
              text: "Today’s work",
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.pale,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '3 jobs',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.green,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildDoNowButton(),
        const SizedBox(height: 9),
        _buildLaterJobs(),
        const SizedBox(height: 14),
        _buildFarmPulse(),
      ],
    );
  }

  Widget _buildDoNowButton() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/feed-type'),
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: const Color(0x17163F3F).withValues(alpha: 0.22),
              blurRadius: 16,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                FontAwesomeIcons.bowlFood.data,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DO NOW',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const OutfitText(
                    text: 'Feed larvae',
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: AppColors.surface,
                    letterSpacing: -0.02,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'START',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.green,
                  letterSpacing: 0.03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaterJobs() {
    return Column(
      children: [
        _buildLaterJob(
          icon: Icons.water_drop,
          iconBg: AppColors.orangebg,
          iconColor: AppColors.orange,
          title: 'Add water',
          subtitle: 'Cage B · later',
          route: '/cages',
        ),
        const SizedBox(height: 9),
        _buildLaterJob(
          icon: Icons.shopping_basket,
          iconBg: AppColors.pale,
          iconColor: AppColors.green,
          title: 'Harvest',
          subtitle: 'Batch 007 · ready',
          route: '/harvest-larvae',
        ),
      ],
    );
  }

  Widget _buildLaterJob({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(11),
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
              width: 31,
              height: 31,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: iconColor, size: 15),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 12,
                      height: 1.15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFC8D4CA),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmPulse() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/farm'),
      child: Container(
        height: 92,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 11),
        decoration: BoxDecoration(
          color: AppColors.greenBg,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFC8D4CA), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.show_chart,
                color: Colors.white,
                size: 19,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOUR FARM THIS WEEK',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF5B7C64),
                    ),
                  ),
                  const OutfitText(
                    text: 'More larvae than last week',
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.green,
                    letterSpacing: -0.02,
                  ),
                ],
              ),
            ),
            const Text(
              'SEE FARM',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.green,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.green,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddFarmWork() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        const OutfitText(
          text: 'Add farm work',
          fontSize: 19,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildHomeAction(
                icon: Icons.food_bank,
                bgColor: AppColors.orangebg,
                iconColor: AppColors.orange,
                title: 'Add waste',
                subtitle: 'Feed larvae',
                route: '/feed-type',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildHomeAction(
                icon: Icons.shopping_basket,
                bgColor: AppColors.pale,
                iconColor: AppColors.green,
                title: 'Harvest',
                subtitle: 'Larvae and frass',
                route: '/harvest-larvae',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHomeAction({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        height: 138,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutfitText(
                  text: title,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.02,
                  color: AppColors.ink,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
