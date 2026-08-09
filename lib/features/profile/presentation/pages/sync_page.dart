import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
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
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
        Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
      ]),
    ]);
  }
}