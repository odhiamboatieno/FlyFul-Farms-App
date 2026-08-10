import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/egg_collection_provider.dart';
import 'package:provider/provider.dart';

class EggQualityPage extends StatefulWidget {
  const EggQualityPage({super.key});

  @override
  State<EggQualityPage> createState() => _EggQualityPageState();
}

class _EggQualityPageState extends State<EggQualityPage> {
  bool _saving = false;

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final ok = await context.read<EggCollectionProvider>().saveEggCollection();
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      context.push('/success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a cage and enter a weight to save.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final egg = context.watch<EggCollectionProvider>();
    final canSave = egg.draftCageId != null && egg.draftEggWeightGrams.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Collect eggs', 'Last question'),
            const SizedBox(height: 16),
            _buildActionTitle('Egg quality?', 'Choose the picture that fits.'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoice(FontAwesomeIcons.star.data, 'best',
                    isSelected: egg.draftQuality == 'best',
                    onTap: () => context.read<EggCollectionProvider>().setQuality('best')),
                _buildChoice(FontAwesomeIcons.thumbsUp.data, 'good',
                    isSelected: egg.draftQuality == 'good',
                    onTap: () => context.read<EggCollectionProvider>().setQuality('good')),
                _buildChoice(FontAwesomeIcons.circleExclamation.data, 'poor',
                    isSelected: egg.draftQuality == 'poor',
                    onTap: () => context.read<EggCollectionProvider>().setQuality('poor')),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: canSave ? _save : null,
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(width: 4),
                      Text('Save eggs'),
                    ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }

  Widget _buildActionTitle(String title, String help) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      OutfitText(text: title, fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink, letterSpacing: -0.02),
      const SizedBox(height: 4),
      Text(help, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
    ]);
  }

  Widget _buildChoice(IconData icon, String label, {bool isSelected = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 108,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.green : AppColors.surface,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: isSelected ? AppColors.green : AppColors.line),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: isSelected ? Colors.white : AppColors.green, size: 16),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.ink)),
        ]),
      ),
    );
  }
}