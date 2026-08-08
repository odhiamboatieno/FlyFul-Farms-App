import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class CagesPage extends StatelessWidget {
  const CagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CageProvider>();
    final cages = provider.cages;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Breeding cages', 'Look after the cages'),
            const SizedBox(height: 16),
            if (provider.loading)
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(child: CircularProgressIndicator(color: AppColors.green)),
              )
            else if (cages.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Column(children: [
                  const Icon(Icons.warehouse_outlined, color: AppColors.muted, size: 40),
                  const SizedBox(height: 12),
                  Text('No cages yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink)),
                  const SizedBox(height: 4),
                  Text('Set up your first breeding cage to get started.',
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ]),
              )
            else
              ...cages.map((c) {
                final tag = c.status == 'active' ? 'Active' : _statusLabel(c.status);
                final tagColor = c.status == 'active' ? AppColors.green : AppColors.orange;
                var icon = Icons.check_circle;
                if (!c.waterAdded) icon = Icons.water_drop;
                if (c.attractantInstalled && c.waterAdded) icon = Icons.check_circle;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: _buildCage(
                    c.cageNumber.isEmpty ? 'Cage ${c.id}' : c.cageNumber,
                    '${c.ageDays} days · ${c.pupaLoadedKg.toStringAsFixed(1)} KG pupa',
                    icon,
                    tagColor,
                    tag,
                    hasEggTask: c.status == 'active' && !c.waterAdded,
                    onTap: () => Navigator.pushNamed(context, '/cages/${c.id}'),
                  ),
                );
              }),
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
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

  Widget _buildCage(String name, String details, IconData taskIcon, Color tagColor, String tag, {required bool hasEggTask, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 3))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
              child: Icon(FontAwesomeIcons.warehouse.data, color: AppColors.green, size: 20)),
            const SizedBox(width: 8),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              OutfitText(text: name, fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
              Text(details, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(color: tagColor == AppColors.orange ? AppColors.orangebg : AppColors.pale, borderRadius: BorderRadius.circular(4)),
              child: Text(tag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: tagColor))),
          ]),
          if (hasEggTask) ...[
            const SizedBox(height: 8),
            Row(children: [
              const Icon(Icons.egg, color: AppColors.green, size: 16),
              const SizedBox(width: 5),
              const Expanded(child: Text('Collect eggs today', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFFC8D4CA), size: 16),
            ]),
          ],
        ]),
      ),
    );
  }
}