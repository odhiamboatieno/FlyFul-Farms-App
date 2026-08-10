import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/features/profile/presentation/providers/sync_provider.dart';
import 'package:provider/provider.dart';

class BatchListPage extends StatefulWidget {
  const BatchListPage({super.key});

  @override
  State<BatchListPage> createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  final _searchController = TextEditingController();

  Future<void> _syncNow() async {
    final sync = context.read<SyncProvider>();
    if (sync.isSyncing) return;
    try {
      await sync.syncNow();
      if (!mounted) return;
      final result = sync.lastResult;
      final downloaded = sync.lastDownloaded;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (result?.processed ?? 0) > 0
                ? 'Synced ${result!.processed} upload + $downloaded downloaded'
                : downloaded > 0
                    ? 'Downloaded $downloaded change(s)'
                    : (result?.failed ?? 0) > 0
                        ? 'Sync failed for ${result!.failed} item(s)'
                        : 'Everything is in sync',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sync failed: $e')),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BatchProvider>();
    final query = _searchController.text.toLowerCase();

    final batches = provider.batches
        .where((b) =>
            query.isEmpty ||
            b.batchNumber.toLowerCase().contains(query) ||
            b.wasteType.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPageHeader(context, 'My batches', 'Tap a batch to see its work'),
              const SizedBox(height: 8),
              _buildLastSyncedChip(),
              const SizedBox(height: 16),
              _buildSearchField(),
              const SizedBox(height: 22),
              if (provider.loading)
                const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(child: CircularProgressIndicator(color: AppColors.green)),
                )
              else if (batches.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Column(children: [
                    const Icon(Icons.inventory_2_outlined, color: AppColors.muted, size: 44),
                    const SizedBox(height: 12),
                    Text('No batches yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                    const SizedBox(height: 4),
                    Text('Create your first batch to get started.',
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () => context.push('/batches/new'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
                      child: const Text('New batch', style: TextStyle(color: Colors.white)),
                    ),
                  ]),
                )
              else
                ...batches.map((b) {
                  final tag = b.status == 'active' ? 'Growing' : b.status;
                  final tagColor = b.status == 'active' ? AppColors.green : AppColors.orange;
                  final icon = b.wasteType.contains('vegetable') || b.wasteType.contains('kitchen')
                      ? Icons.eco
                      : Icons.shopping_basket;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: _buildBatch(
                      b.batchNumber,
                      '${_wasteLabel(b.wasteType)} · Day ${b.dayNumber}',
                      icon,
                      tagColor,
                      tag,
                      onTap: () => context.push('/batches/${b.id}'),
                    ),
                  );
                }),
            ],
          ),
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

  Widget _buildPageHeader(BuildContext context, String title, String subtitle) {
    return Row(children: [
      GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_back_ios, color: AppColors.ink, size: 20)),
      const SizedBox(width: 8),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutfitText(text: title, fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink),
          Text(subtitle, style: TextStyle(fontSize: 15, height: 1.45, color: AppColors.textSecondary)),
        ]),
      ),
      IconButton(
        onPressed: () => context.push('/batches/new'),
        tooltip: 'New batch',
        icon: const Icon(Icons.add, color: AppColors.green, size: 24),
      ),
      IconButton(
        onPressed: _buildHeaderSyncIconOnPressed(context),
        tooltip: 'Sync offline changes',
        icon: _buildHeaderSyncIcon(context),
      ),
    ]);
  }

  VoidCallback? _buildHeaderSyncIconOnPressed(BuildContext context) {
    return context.read<SyncProvider>().isSyncing ? null : _syncNow;
  }

  Widget _buildHeaderSyncIcon(BuildContext context) {
    return context.watch<SyncProvider>().isSyncing
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.green),
          )
        : const Icon(Icons.sync, color: AppColors.green, size: 22);
  }

  Widget _buildLastSyncedChip() {
    final sync = context.watch<SyncProvider>();
    final last = sync.lastSyncedAt;
    final syncing = sync.isSyncing;
    final String label;
    if (syncing) {
      label = 'Syncing…';
    } else if (last == null) {
      label = 'Not synced yet';
    } else {
      final now = DateTime.now();
      final diff = now.difference(last);
      label = diff.inMinutes < 1
          ? 'Just synced'
          : diff.inHours < 1
              ? 'Synced ${diff.inMinutes} min ago'
              : 'Synced ${diff.inHours} h ago';
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.greenBg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.orangebg),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          syncing
              ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 1.6, color: AppColors.green),
                )
              : const Icon(Icons.cloud_done, color: AppColors.green, size: 14),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.green)),
        ]),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 58,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Find batch number',
          hintStyle: TextStyle(color: AppColors.muted, fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: AppColors.muted, size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildBatch(String number, String subtitle, IconData icon, Color tagColor, String tag, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
        child: Row(children: [
          Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, color: AppColors.green, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            OutfitText(text: number, fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
            Text(subtitle, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(
            color: tagColor == AppColors.green ? AppColors.pale : AppColors.orangebg,
            borderRadius: BorderRadius.circular(4)),
            child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: tagColor))),
        ]),
      ),
    );
  }
}
