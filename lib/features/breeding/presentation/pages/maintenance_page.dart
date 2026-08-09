import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/core/database/app_database.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/maintenance_provider.dart';
import 'package:provider/provider.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  bool _saving = false;

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final ok = await context.read<MaintenanceProvider>().saveMaintenance();
    if (!mounted) return;
    setState(() => _saving = false);
    if (ok) {
      Navigator.pushNamed(context, '/success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a cage to save maintenance.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final maintenance = context.watch<MaintenanceProvider>();
    final cages = context.watch<CageProvider>().cages;
    final hasCage = maintenance.draftCageId != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Cage maintenance', 'Look after the cages'),
            const SizedBox(height: 16),
            _buildCagePicker(context, maintenance, cages),
            const SizedBox(height: 16),
            _buildToggle('Water changed', Icons.water_drop, maintenance.waterChanged,
                (v) => maintenance.setWaterChanged(v)),
            const SizedBox(height: 8),
            _buildToggle('Attractant replaced', Icons.sensors, maintenance.attractantReplaced,
                (v) => maintenance.setAttractantReplaced(v)),
            const SizedBox(height: 8),
            _buildToggle('Cleaning done', Icons.cleaning_services, maintenance.cleaningDone,
                (v) => maintenance.setCleaningDone(v)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: hasCage ? _save : null,
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.check, size: 16),
                      SizedBox(width: 4),
                      Text('Save maintenance'),
                    ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildCagePicker(
    BuildContext context,
    MaintenanceProvider maintenance,
    List<BreedingCage> cages,
  ) {
    if (cages.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
        child: Row(children: [
          const Icon(Icons.info_outline, color: AppColors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Create a cage first to log maintenance.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
        ]),
      );
    }

    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: maintenance.draftCageId,
          isExpanded: true,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Select cage', style: TextStyle(color: AppColors.muted)),
          ),
          items: cages.map((c) {
            return DropdownMenuItem(
              value: c.remoteId,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(c.cageNumber,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink)),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) maintenance.setCageId(value);
          },
        ),
      ),
    );
  }

  Widget _buildToggle(String label, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Icon(icon, color: AppColors.green, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink)),
        ),
        Switch(value: value, onChanged: onChanged, activeTrackColor: AppColors.green),
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
}