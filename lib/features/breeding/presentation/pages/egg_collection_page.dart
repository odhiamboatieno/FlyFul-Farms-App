import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class EggCollectionPage extends StatefulWidget {
  const EggCollectionPage({super.key});

  @override
  State<EggCollectionPage> createState() => _EggCollectionPageState();
}

class _EggCollectionPageState extends State<EggCollectionPage> {
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Collect eggs', 'Cage A · first question'),
            const SizedBox(height: 16),
            _buildDateEntry(),
            const SizedBox(height: 16),
            _buildActionTitle('Egg weight?', 'Put eggs on the scale.'),
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '0.0',
                hintStyle: TextStyle(color: AppColors.muted, fontSize: 32, height: 1),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/egg-quality'),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.arrow_forward, size: 16),
                SizedBox(width: 4),
                Text('Next'),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }

  Widget _buildDateEntry() {
    return Row(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.calendar_today, color: AppColors.green, size: 16)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('SAVED DATE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 0.04)),
        Text('Today', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, height: 1.2, color: AppColors.ink)),
      ])),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(children: [
          const Icon(Icons.lock, color: AppColors.green, size: 14),
          const SizedBox(width: 4),
          Text('Today only', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.green)),
        ]),
      ),
    ]);
  }

  Widget _buildActionTitle(String title, String help) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      OutfitText(text: title, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink, letterSpacing: -0.02),
      const SizedBox(height: 4),
      Text(help, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
    ]);
  }
}
