import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class HarvestLarvaePage extends StatefulWidget {
  const HarvestLarvaePage({super.key});

  @override
  State<HarvestLarvaePage> createState() => _HarvestLarvaePageState();
}

class _HarvestLarvaePageState extends State<HarvestLarvaePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
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
            _buildPageHeaderStepper(context, 'Harvest Batch 007', 'First question', 1),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            _buildActionTitle('Larvae weight?', 'Put larvae on the scale.'),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
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
              onPressed: () => Navigator.pushNamed(context, '/harvest-frass'),
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

  Widget _buildPageHeaderStepper(BuildContext context, String title, String subtitle, int step) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ])),
      _buildStepper(step, 3),
    ]);
  }

  Widget _buildStepper(int current, int total) {
    return Row(children: List.generate(total, (i) {
      final isActive = i + 1 < current;
      final isCurrent = i + 1 == current;
      return Container(
        width: 8, height: 8, margin: EdgeInsets.only(left: i > 0 ? 5 : 0),
        decoration: BoxDecoration(shape: BoxShape.circle, color: isActive || isCurrent ? AppColors.green : const Color(0xFFC8D4CA)),
      );
    }));
  }

  Widget _buildActionTitle(String title, String help) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      OutfitText(text: title, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink, letterSpacing: -0.02),
      const SizedBox(height: 4),
      Text(help, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
    ]);
  }
}
