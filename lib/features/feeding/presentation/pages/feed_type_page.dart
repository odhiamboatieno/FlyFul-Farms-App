import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/feeding/presentation/providers/feeding_provider.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:provider/provider.dart';

class FeedTypePage extends StatefulWidget {
  const FeedTypePage({super.key});

  @override
  State<FeedTypePage> createState() => _FeedTypePageState();
}

class _FeedTypePageState extends State<FeedTypePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _foodTypes = [
    {'icon': Icons.eco, 'label': 'Vegetables'},
    {'icon': Icons.apple, 'label': 'Fruit'},
    {'icon': Icons.shopping_basket, 'label': 'Market waste'},
    {'icon': Icons.recycling, 'label': 'Mixed waste'},
  ];

  @override
  Widget build(BuildContext context) {
    final feeding = context.watch<FeedingProvider>();
    final batches = context.watch<BatchProvider>().batches;
    Batche? selectedBatch;
    for (final b in batches) {
      if (b.remoteId == feeding.draftBatchId) {
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
            _buildPageHeaderStepper(context, 'Feed larvae', 'First question'),
            const SizedBox(height: 16),
            _buildBatchPicker(context, feeding, batches, selectedBatch),
            const SizedBox(height: 16),
            _buildActionTitle('What food did you add?', 'Choose one picture.'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _foodTypes.asMap().entries.map((entry) {
                final i = entry.key;
                final data = entry.value;
                return _buildChoice(data['icon'], data['label'],
                    isSelected: _selectedIndex == i,
                    onTap: () {
                      setState(() => _selectedIndex = i);
                      feeding.setWasteType(
                        data['label'].toString().toLowerCase().replaceAll(' ', '_'),
                      );
                    });
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/feed'),
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
    FeedingProvider feeding,
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
            child: Text('Create a batch first to add a feeding record.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: feeding.draftBatchId,
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
            if (value != null) feeding.setBatchId(value);
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

  Widget _buildPageHeaderStepper(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ])),
      _buildStepper(1, 3),
    ]);
  }

  Widget _buildStepper(int current, int total) {
    return Row(children: List.generate(total, (i) {
      final isActive = i < current;
      final isCurrent = i + 1 == current;
      return Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.only(left: i > 0 ? 5 : 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrent || isActive ? AppColors.green : const Color(0xFFC8D4CA),
        ),
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
          Icon(icon, color: isSelected ? Colors.white : AppColors.green, size: 19),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.ink)),
        ]),
      ),
    );
  }
}