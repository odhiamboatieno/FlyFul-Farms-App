import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/harvest/presentation/providers/harvest_provider.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:provider/provider.dart';

class HarvestLarvaePage extends StatefulWidget {
  const HarvestLarvaePage({super.key});

  @override
  State<HarvestLarvaePage> createState() => _HarvestLarvaePageState();
}

class _HarvestLarvaePageState extends State<HarvestLarvaePage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HarvestProvider>().reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next(BuildContext context) {
    final weight = double.tryParse(_controller.text.trim()) ?? 0;
    if (weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a weight above 0')),
      );
      return;
    }
    context.read<HarvestProvider>().setWetLarvaeKg(weight);
    context.push('/harvest-frass');
  }

  @override
  Widget build(BuildContext context) {
    final harvest = context.watch<HarvestProvider>();
    final batches = context.watch<BatchProvider>().batches;

    Batche? selectedBatch;
    for (final b in batches) {
      if (b.remoteId == harvest.draftBatchId) {
        selectedBatch = b;
        break;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeaderStepper(context, 'Harvest larvae', 'First question', 1),
            const SizedBox(height: 16),
            _buildBatchPicker(context, harvest, batches, selectedBatch),
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
              onPressed: harvest.draftBatchId == null ? null : () => _next(context),
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

  Widget _buildBatchPicker(
    BuildContext context,
    HarvestProvider harvest,
    List<Batche> batches,
    Batche? selectedBatch,
  ) {
    if (batches.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          const Icon(Icons.info_outline, color: AppColors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Create a batch first to add a harvest record.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: harvest.draftBatchId,
          isExpanded: true,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Select batch', style: TextStyle(color: AppColors.muted)),
          ),
          items: batches.map((b) {
            return DropdownMenuItem(
              value: b.remoteId,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('${b.batchNumber} · ${_wasteLabel(b.wasteType)}',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink)),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) harvest.setBatchId(value);
          },
        ),
      ),
    );
  }

  String _wasteLabel(String wasteType) {
    switch (wasteType) {
      case 'vegetables':
        return 'Vegetables';
      case 'market_waste':
        return 'Market waste';
      case 'kitchen_waste':
        return 'Kitchen waste';
      default:
        return wasteType.isEmpty ? 'Mixed waste' : wasteType.replaceAll('_', ' ');
    }
  }

  Widget _buildPageHeaderStepper(BuildContext context, String title, String subtitle, int step) {
    return Row(children: [
      GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
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