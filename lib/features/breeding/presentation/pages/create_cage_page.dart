import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:provider/provider.dart';

class CreateCagePage extends StatefulWidget {
  const CreateCagePage({super.key});

  @override
  State<CreateCagePage> createState() => _CreateCagePageState();
}

class _CreateCagePageState extends State<CreateCagePage> {
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _pupaController = TextEditingController();
  final _sourceController = TextEditingController();
  final _notesController = TextEditingController();
  bool _waterAdded = false;
  bool _attractantInstalled = false;
  bool _saving = false;

  @override
  void dispose() {
    _numberController.dispose();
    _ageController.dispose();
    _pupaController.dispose();
    _sourceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
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
      await context.read<CageProvider>().createCage(
        cageNumber: number,
        ageDays: age,
        pupaLoadedKg: pupa,
        pupaSource: _sourceController.text.trim().isEmpty ? null : _sourceController.text.trim(),
        attractantInstalled: _attractantInstalled,
        waterAdded: _waterAdded,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      if (!mounted) return;
      context.push('/success');
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
            _buildPageHeader(context, 'New cage', 'Enter cage details'),
            const SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Cage number'),
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
            Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(5),
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
              onPressed: _saving ? null : _create,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
              child: _saving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('CREATE CAGE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
    );
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