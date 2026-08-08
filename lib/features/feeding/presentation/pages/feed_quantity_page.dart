import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/feeding/presentation/providers/feeding_provider.dart';
import 'package:provider/provider.dart';

class FeedQuantityPage extends StatefulWidget {
  const FeedQuantityPage({super.key});

  @override
  State<FeedQuantityPage> createState() => _FeedQuantityPageState();
}

class _FeedQuantityPageState extends State<FeedQuantityPage> {
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController.text =
        Provider.of<FeedingProvider>(context, listen: false).draftQuantityKg == 0
            ? '12'
            : Provider.of<FeedingProvider>(context, listen: false)
                .draftQuantityKg
                .toString();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _next(BuildContext context) {
    final weight = double.tryParse(_weightController.text.trim()) ?? 0;
    if (weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a quantity above 0')),
      );
      return;
    }
    context.read<FeedingProvider>().setQuantityKg(weight);
    Navigator.pushNamed(context, '/feed-photo');
  }

  @override
  Widget build(BuildContext context) {
    final feeding = context.watch<FeedingProvider>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeaderStepper(context, 'Feed larvae', 'Second question'),
            const SizedBox(height: 16),
            _buildDateEntry(),
            const SizedBox(height: 16),
            _buildActionTitle('How many kilograms?', 'Use the weighing scale number.'),
            const SizedBox(height: 8),
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
              onPressed: feeding.draftBatchId == null ? null : () => _next(context),
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

  Widget _buildPageHeaderStepper(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ])),
      _buildStepper(2, 3),
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

  Widget _buildDateEntry() {
    return Row(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.calendar_today, color: AppColors.green, size: 16)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('SAVED DATE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 0.04)),
        Text('Today', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
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