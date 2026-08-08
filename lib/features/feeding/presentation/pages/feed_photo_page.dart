import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/feeding/presentation/providers/feeding_provider.dart';
import 'package:provider/provider.dart';

class FeedPhotoPage extends StatefulWidget {
  const FeedPhotoPage({super.key});

  @override
  State<FeedPhotoPage> createState() => _FeedPhotoPageState();
}

class _FeedPhotoPageState extends State<FeedPhotoPage> {
  bool _saving = false;

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final ok = await context.read<FeedingProvider>().saveFeeding();
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.pushNamed(context, '/success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a batch, food type, and quantity to save.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final feeding = context.watch<FeedingProvider>();
    final canSave = feeding.draftBatchId != null &&
        feeding.draftWasteType.isNotEmpty &&
        feeding.draftQuantityKg > 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeaderStepper(context, 'Almost done', 'Photo is optional'),
            const SizedBox(height: 16),
            _buildActionTitle('Take a photo?', 'A photo helps you remember what you fed the larvae.'),
            const SizedBox(height: 16),
            Container(
              height: 138,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.line, style: BorderStyle.none),
              ),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.camera_alt, color: AppColors.green, size: 32),
                  const SizedBox(height: 8),
                  OutfitText(text: 'Take food photo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.green),
                ]),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: canSave ? _save : null,
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(width: 4),
                      Text('Save feeding'),
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
      _buildStepper(3, 3),
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