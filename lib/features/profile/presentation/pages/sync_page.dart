import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/profile/presentation/providers/sync_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sync = context.watch<SyncProvider>();

    final pending = sync.pendingCount;
    final last = sync.lastSyncedAt;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Offline & sync', 'Your work is safe'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.greenBg,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.orangebg),
              ),
              child: Row(children: [
                Container(width: 43, height: 43, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(7)),
                  child: const Icon(Icons.cloud_upload, color: Colors.white, size: 19)),
                const SizedBox(width: 11),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    pending == 0 ? 'Everything is synced' : '$pending ${pending == 1 ? 'record' : 'records'} waiting',
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.green),
                  ),
                  Text(_lastSyncedLabel(last), style: const TextStyle(fontSize: 11, color: Color(0xFF5B7C64))),
                ])),
              ]),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: sync.isSyncing ? null : () => context.read<SyncProvider>().syncNow(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
              child: sync.isSyncing
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.sync, size: 16),
                      SizedBox(width: 4),
                      Text('Sync now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ]),
            ),
            if (sync.hasSyncError) ...[
              const SizedBox(height: 8),
              const Text('Last sync had errors. Check your connection and try again.',
                  style: TextStyle(fontSize: 12, color: AppColors.orange)),
            ],
            const SizedBox(height: 24),
            Text(pending == 0 ? 'Nothing waiting to send' : 'Waiting to send',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink)),
            const SizedBox(height: 10),
            if (pending == 0)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.orangebg),
                ),
                child: const Text('All your saved records have been sent to the server.',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              )
            else
              ...sync.pendingOperations.map((op) => _PendingItem(op: op)),
            const SizedBox(height: 24),
            Text(sync.hasConflicts ? 'Conflicts' : 'Nothing needs your attention',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink)),
            const SizedBox(height: 10),
            if (sync.hasConflicts)
              ...sync.conflicts.map((c) => _ConflictItem(conflict: c))
            else
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.orangebg),
                ),
                child: const Text('No sync conflicts right now.',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  String _lastSyncedLabel(DateTime? last) {
    if (last == null) return 'Not synced yet. They will send when internet returns.';
    final fmt = DateFormat('HH:mm');
    return 'Last synced today at ${fmt.format(last.toLocal())}.';
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
}

class _PendingItem extends StatelessWidget {
  final SyncOutboxe op;
  const _PendingItem({required this.op});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.orangebg),
      ),
      child: Row(children: [
        Icon(_iconFor(op.entityType), color: AppColors.green, size: 19),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_labelFor(op.entityType, op.operation),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink)),
            Text(_metaLabel(op), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ]),
        ),
        if (op.errorMessage != null)
          const Tooltip(
            message: 'Failed to send',
            child: Icon(Icons.error_outline, color: AppColors.orange, size: 16),
          ),
      ]),
    );
  }

  String _metaLabel(SyncOutboxe op) {
    final time = DateFormat('HH:mm').format(op.createdAt.toLocal());
    final base = op.operation == 'delete' ? 'Queued to delete at $time' : 'Saved at $time';
    return op.errorMessage == null ? base : '$base — will retry on next sync';
  }

  IconData _iconFor(String entityType) {
    switch (entityType) {
      case 'batch':
        return Icons.grain;
      case 'breeding_cage':
        return Icons.holiday_village_outlined;
      case 'feeding':
        return Icons.restaurant;
      case 'harvest':
        return Icons.savings;
      case 'egg_collection':
        return Icons.egg_outlined;
      case 'cage_maintenance':
        return Icons.cleaning_services_outlined;
      default:
        return Icons.cloud_upload_outlined;
    }
  }

  String _labelFor(String entityType, String operation) {
    final action = operation == 'delete' ? 'Deleted' : 'New';
    switch (entityType) {
      case 'batch':
        return '$action batch';
      case 'breeding_cage':
        return '$action breeding cage';
      case 'feeding':
        return '$action feeding record';
      case 'harvest':
        return '$action harvest record';
      case 'egg_collection':
        return '$action egg collection';
      case 'cage_maintenance':
        return '$action cage maintenance';
      default:
        return '$action record';
    }
  }
}

class _ConflictItem extends StatelessWidget {
  final Map<String, dynamic> conflict;
  const _ConflictItem({required this.conflict});

  @override
  Widget build(BuildContext context) {
    final entityType = conflict['entityType']?.toString() ?? 'record';
    final reason = conflict['reason']?.toString() ?? 'This record was changed on another device.';
    final conflictId = conflict['id']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.orangebg),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.warning_amber, color: AppColors.orange, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Conflict · $entityType',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ink),
            ),
          ),
        ]),
        const SizedBox(height: 6),
        Text(reason, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: conflictId.isEmpty
                  ? null
                  : () => _resolve(context, conflictId, 'server_wins'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text('Keep server'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: conflictId.isEmpty
                  ? null
                  : () => _resolve(context, conflictId, 'client_wins'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text('Keep mine', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ]),
    );
  }

  Future<void> _resolve(BuildContext context, String conflictId, String resolution) async {
    final sync = context.read<SyncProvider>();
    final ok = await sync.resolveConflict(conflictId, resolution);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Conflict resolved' : 'Could not resolve the conflict.')),
    );
  }
}