import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:provider/provider.dart';

class BatchDetailPage extends StatelessWidget {
  final int id;
  const BatchDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BatchProvider>();
    final batch = provider.batchById(id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, batch?.batchNumber ?? 'Batch $id', batch == null
                ? 'Batch not found'
                : '${_wasteLabel(batch.wasteType)} · Day ${batch.dayNumber}'),
            if (batch != null) ...[
              const SizedBox(height: 16),
              _buildInfoCard(batch),
              const SizedBox(height: 9),
              _buildStatCard('Waste quantity', '${batch.wasteQuantityKg.toStringAsFixed(1)} KG', Icons.shopping_basket),
              const SizedBox(height: 9),
              _buildStatCard('Neonates added', '${batch.neonatesAdded}', Icons.eco),
              const SizedBox(height: 9),
              _buildStatCard('Status', batch.status, Icons.speed),
            ],
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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

  Widget _buildInfoCard(dynamic batch) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Batch details', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        _infoRow('Waste type', _wasteLabel(batch.wasteType)),
        _infoRow('Farmer', batch.farmerName.isEmpty ? '—' : batch.farmerName),
        _infoRow('Started', batch.startDate.isEmpty ? '—' : batch.startDate.substring(0, 10)),
      ]),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink)),
      ]),
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

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      height: 118,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon, color: AppColors.green, size: 24),
        Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.ink)),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
      ]),
    );
  }
}
