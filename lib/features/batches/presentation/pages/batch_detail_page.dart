import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/features/records/presentation/providers/record_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BatchDetailPage extends StatefulWidget {
  final int id;
  const BatchDetailPage({super.key, required this.id});

  @override
  State<BatchDetailPage> createState() => _BatchDetailPageState();
}

class _BatchDetailPageState extends State<BatchDetailPage> {
  String? _loadedBatchId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final batch = context.read<BatchProvider>().batchById(widget.id);
    final remoteId = batch?.remoteId;
    if (remoteId != null && remoteId != _loadedBatchId) {
      _loadedBatchId = remoteId;
      context.read<RecordProvider>().loadBatchRecords(remoteId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BatchProvider>();
    final batch = provider.batchById(widget.id);
    final records = context.watch<RecordProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, batch?.batchNumber ?? 'Batch ${widget.id}', batch == null
                ? 'Batch not found'
                : '${_wasteLabel(batch.wasteType)} · Day ${batch.dayNumber}', onDelete: batch == null
                ? null
                : () => _confirmDelete(context, batch)),
            if (batch != null) ...[
              const SizedBox(height: 16),
              _buildInfoCard(batch),
              const SizedBox(height: 9),
              _buildStatCard('Waste quantity', '${batch.wasteQuantityKg.toStringAsFixed(1)} KG', Icons.shopping_basket),
              const SizedBox(height: 9),
              _buildStatCard('Neonates added', '${batch.neonatesAdded}', Icons.eco),
              const SizedBox(height: 9),
              _buildStatCard('Status', batch.status, Icons.speed),
              const SizedBox(height: 16),
              _buildSectionHeader('Feeding records'),
              const SizedBox(height: 10),
              if (records.loading)
                const Center(child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: AppColors.green)))
              else if (records.feedings.isEmpty)
                _buildEmpty('No feeding records yet.')
              else
                ...records.feedings.map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildRecord(
                        Icons.food_bank,
                        _wasteLabel(f.wasteType.isEmpty ? 'mixed' : f.wasteType),
                        '${f.wasteQuantityKg.toStringAsFixed(1)} KG · ${DateFormat('MMM d').format(f.fedAt)}',
                      ),
                    )),
              const SizedBox(height: 14),
              _buildSectionHeader('Harvest records'),
              const SizedBox(height: 10),
              if (records.harvests.isEmpty)
                _buildEmpty('No harvest records yet.')
              else
                ...records.harvests.map((h) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildRecord(
                        Icons.shopping_basket,
                        'Larvae ${h.wetLarvaeKg.toStringAsFixed(1)} KG',
                        'Frass ${(h.frassKg ?? 0).toStringAsFixed(1)} KG · ${DateFormat('MMM d').format(h.harvestedAt)}',
                      ),
                    )),
            ],
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
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

  Widget _buildRecord(IconData icon, String title, String subtitle) {
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
      ]),
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

  Future<void> _confirmDelete(BuildContext context, dynamic batch) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete batch?'),
        content: Text('Delete ${batch.batchNumber}? This syncs to the server on next sync.'),
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
      await context.read<BatchProvider>().deleteBatch(widget.id);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildPageHeader(BuildContext context, String title, String subtitle, {VoidCallback? onDelete}) {
    return Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
        ]),
      ),
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