import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:flyful_farms/features/records/presentation/providers/record_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CageDetailPage extends StatefulWidget {
  final int id;
  const CageDetailPage({super.key, required this.id});

  @override
  State<CageDetailPage> createState() => _CageDetailPageState();
}

class _CageDetailPageState extends State<CageDetailPage> {
  String? _loadedCageId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cage = context.read<CageProvider>().cageById(widget.id);
    final remoteId = cage?.remoteId;
    if (remoteId != null && remoteId != _loadedCageId) {
      _loadedCageId = remoteId;
      context.read<RecordProvider>().loadCageRecords(remoteId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CageProvider>();
    final cage = provider.cageById(widget.id);
    final records = context.watch<RecordProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, cage?.cageNumber ?? 'Cage ${widget.id}', cage == null
                ? 'Cage not found'
                : '${_statusLabel(cage.status)} · Day ${cage.ageDays}', onDelete: cage == null
                ? null
                : () => _confirmDelete(context, cage), onEdit: cage == null
                ? null
                : () => Navigator.pushNamed(context, '/cages/${widget.id}/edit')),
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
              const SizedBox(height: 16),
              _buildSectionHeader('Egg collections'),
              const SizedBox(height: 10),
              if (records.loading)
                const Center(child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: AppColors.green)))
              else if (records.eggCollections.isEmpty)
                _buildEmpty('No egg collections yet.')
              else
                ...records.eggCollections.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildRecord(
                        Icons.egg,
                        '${e.eggWeightGrams.isEmpty ? '0' : e.eggWeightGrams} g',
                        '${_qualityLabel(e.quality)} · ${DateFormat('MMM d').format(e.collectedAt)}',
                        onDelete: () => _confirmDeleteRecord(
                          context,
                          description: 'Delete this egg collection record?',
                          onDelete: () => context.read<RecordProvider>().deleteEggCollection(e),
                        ),
                      ),
                    )),
              const SizedBox(height: 14),
              _buildSectionHeader('Maintenance'),
              const SizedBox(height: 10),
              if (records.maintenances.isEmpty)
                _buildEmpty('No maintenance records yet.')
              else
                ...records.maintenances.map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildRecord(
                        Icons.cleaning_services,
                        _maintenanceLabel(m),
                        DateFormat('MMM d').format(m.maintenanceDate),
                        onDelete: () => _confirmDeleteRecord(
                          context,
                          description: 'Delete this maintenance record?',
                          onDelete: () => context.read<RecordProvider>().deleteMaintenance(m),
                        ),
                      ),
                    )),
            ],
          ]),
        ),
      ),
    );
  }

  String _maintenanceLabel(dynamic m) {
    final parts = <String>[
      if (m.waterChanged) 'Water',
      if (m.attractantReplaced) 'Attractant',
      if (m.cleaningDone) 'Cleaning',
    ];
    return parts.isEmpty ? 'Maintenance' : parts.join(' + ');
  }

  Widget _buildSectionHeader(String title) {
    return Align(alignment: Alignment.centerLeft,
        child: OutfitText(text: title, fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink));
  }

  Widget _buildEmpty(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(message, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    );
  }

  Widget _buildRecord(IconData icon, String title, String subtitle, {VoidCallback? onDelete}) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
      child: Row(children: [
        Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
          child: Icon(icon, color: AppColors.green, size: 20)),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ])),
        if (onDelete != null)
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: AppColors.red, size: 19),
          ),
      ]),
    );
  }

  Future<void> _confirmDeleteRecord(
    BuildContext context, {
    required String description,
    required Future<void> Function() onDelete,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete record?'),
        content: Text(description),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await onDelete();
    }
  }

  String _qualityLabel(String quality) {
    switch (quality) {
      case 'best':
        return 'Best';
      case 'poor':
        return 'Poor';
      default:
        return 'Good';
    }
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

  Future<void> _confirmDelete(BuildContext context, dynamic cage) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete cage?'),
        content: Text('Delete cage ${cage.cageNumber}? This syncs to the server on next sync.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<CageProvider>().deleteCage(widget.id);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle, {VoidCallback? onDelete, VoidCallback? onEdit}) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
        ]),
      ),
      if (onEdit != null)
        IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined, color: AppColors.green, size: 20)),
      if (onDelete != null)
        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: AppColors.red, size: 21)),
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