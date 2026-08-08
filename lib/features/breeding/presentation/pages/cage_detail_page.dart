import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class CageDetailPage extends StatelessWidget {
  final int id;
  const CageDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CageProvider>();
    final cage = provider.cageById(id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, cage?.cageNumber ?? 'Cage $id', cage == null
                ? 'Cage not found'
                : '${_statusLabel(cage.status)} · Day ${cage.ageDays}'),
            if (cage != null) ...[
              const SizedBox(height: 16),
              _buildInfoCard(cage),
              const SizedBox(height: 9),
              _buildStatCard('Pupa loaded', '${cage.pupaLoadedKg.toStringAsFixed(1)} KG', Icons.shutter_speed),
              const SizedBox(height: 9),
              _buildStatCard('Age', '${cage.ageDays} days', Icons.schedule),
              const SizedBox(height: 9),
              _buildStatCard('Attractant', cage.attractantInstalled ? 'Installed' : 'Pending', Icons.sensors),
              const SizedBox(height: 9),
              _buildStatCard('Water', cage.waterAdded ? 'Added' : 'Needed', Icons.water_drop),
            ],
          ]),
        ),
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'empty':
        return 'Empty';
      case 'active':
        return 'Active';
      case 'maintenance':
        return 'Maintenance';
      case 'retired':
        return 'Retired';
      default:
        return status.isEmpty ? 'Active' : status.replaceAll('_', ' ');
    }
  }

  Widget _buildInfoCard(dynamic cage) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Breeding details', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        _infoRow('Status', _statusLabel(cage.status)),
        _infoRow('Pupa source', cage.pupaSource?.isEmpty ?? true ? '—' : cage.pupaSource!),
        _infoRow('Notes', cage.notes?.isEmpty ?? true ? '—' : cage.notes!),
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