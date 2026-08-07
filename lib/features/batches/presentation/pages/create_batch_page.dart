import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class CreateBatchPage extends StatelessWidget {
  const CreateBatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'New batch', 'Enter batch details'),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Batch number')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Waste type')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Quantity (KG)'), keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('CREATE BATCH')),
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
}
