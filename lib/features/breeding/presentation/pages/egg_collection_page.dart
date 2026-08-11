import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/egg_collection_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class EggCollectionPage extends StatefulWidget {
  const EggCollectionPage({super.key});

  @override
  State<EggCollectionPage> createState() => _EggCollectionPageState();
}

class _EggCollectionPageState extends State<EggCollectionPage> {
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<EggCollectionProvider>().reset();
      }
    });
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
        const SnackBar(content: Text('Enter a weight above 0')),
      );
      return;
    }
    context.read<EggCollectionProvider>().setEggWeightGrams(_weightController.text.trim());
    context.push('/egg-quality');
  }

  @override
  Widget build(BuildContext context) {
    final egg = context.watch<EggCollectionProvider>();
    final cages = context.watch<CageProvider>().cages;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Collect eggs', 'First question'),
            const SizedBox(height: 16),
            _buildCagePicker(context, egg, cages),
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
              onPressed: egg.draftCageId == null ? null : () => _next(context),
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

  Widget _buildCagePicker(
    BuildContext context,
    EggCollectionProvider egg,
    List<BreedingCage> cages,
  ) {
    if (cages.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          const Icon(Icons.info_outline, color: AppColors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Create a cage first to collect eggs.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: egg.draftCageId,
          isExpanded: true,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Select cage', style: TextStyle(color: AppColors.muted)),
          ),
          items: cages.map((c) {
            return DropdownMenuItem(
              value: c.remoteId,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(c.cageNumber,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink)),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) egg.setCageId(value);
          },
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