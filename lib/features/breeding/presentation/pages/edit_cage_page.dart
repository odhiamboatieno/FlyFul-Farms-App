import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class EditCagePage extends StatefulWidget {
  final int id;
  const EditCagePage({super.key, required this.id});

  @override
  State<EditCagePage> createState() => _EditCagePageState();
}

class _EditCagePageState extends State<EditCagePage> {
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _pupaController = TextEditingController();
  final _sourceController = TextEditingController();
  final _notesController = TextEditingController();
  String _status = 'active';
  bool _waterAdded = false;
  bool _attractantInstalled = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final cage = context.read<CageProvider>().cageById(widget.id);
    if (cage != null) {
      _numberController.text = cage.cageNumber;
      _ageController.text = cage.ageDays == 0 ? '' : cage.ageDays.toString();
      _pupaController.text = cage.pupaLoadedKg == 0 ? '' : cage.pupaLoadedKg.toString();
      _sourceController.text = cage.pupaSource ?? '';
      _notesController.text = cage.notes ?? '';
      _status = cage.status;
      _waterAdded = cage.waterAdded;
      _attractantInstalled = cage.attractantInstalled;
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    _ageController.dispose();
    _pupaController.dispose();
    _sourceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final number = _numberController.text.trim();
    if (number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a cage number')),
      );
      return;
    }

    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    final pupa = double.tryParse(_pupaController.text.trim()) ?? 0;

    setState(() => _saving = true);
    try {
      await context.read<CageProvider>().updateCage(
        widget.id,
        cageNumber: number,
        status: _status,
        ageDays: age,
        pupaLoadedKg: pupa,
        pupaSource: _sourceController.text.trim().isEmpty ? null : _sourceController.text.trim(),
        waterAdded: _waterAdded,
        attractantInstalled: _attractantInstalled,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save cage. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Edit cage', 'Changes sync to your server'),
            const SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Cage number'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'empty', child: Text('Empty')),
                DropdownMenuItem(value: 'retired', child: Text('Retired')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age (days)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pupaController,
              decoration: const InputDecoration(labelText: 'Pupa loaded (KG)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(labelText: 'Pupa source'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
              child: Column(children: [
                SwitchListTile(
                  title: const Text('Water added', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
                  value: _waterAdded,
                  activeTrackColor: AppColors.green,
                  onChanged: (v) => setState(() => _waterAdded = v),
                ),
                SwitchListTile(
                  title: const Text('Attractant installed', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink)),
                  value: _attractantInstalled,
                  activeTrackColor: AppColors.green,
                  onChanged: (v) => setState(() => _attractantInstalled = v),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('SAVE CHANGES', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
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