import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:provider/provider.dart';

class EditBatchPage extends StatefulWidget {
  final int id;
  const EditBatchPage({super.key, required this.id});

  @override
  State<EditBatchPage> createState() => _EditBatchPageState();
}

class _EditBatchPageState extends State<EditBatchPage> {
  final _numberController = TextEditingController();
  final _wasteController = TextEditingController();
  final _quantityController = TextEditingController();
  final _neonatesController = TextEditingController();
  final _notesController = TextEditingController();
  String _status = 'active';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final batch = context.read<BatchProvider>().batchById(widget.id);
    if (batch != null) {
      _numberController.text = batch.batchNumber;
      _wasteController.text = batch.wasteType.replaceAll('_', ' ');
      _quantityController.text = batch.wasteQuantityKg == 0 ? '' : batch.wasteQuantityKg.toString();
      _neonatesController.text = batch.neonatesAdded == 0 ? '' : batch.neonatesAdded.toString();
      _notesController.text = batch.notes ?? '';
      _status = batch.status;
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    _wasteController.dispose();
    _quantityController.dispose();
    _neonatesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final number = _numberController.text.trim();
    final waste = _wasteController.text.trim();
    final quantity = double.tryParse(_quantityController.text.trim()) ?? 0;
    final neonates = int.tryParse(_neonatesController.text.trim()) ?? 0;
    final notes = _notesController.text.trim();

    if (number.isEmpty || waste.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in batch number and waste type')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final wasteType = waste.toLowerCase().replaceAll(' ', '_');
      await context.read<BatchProvider>().updateBatch(
        widget.id,
        batchNumber: number,
        wasteType: wasteType,
        wasteQuantityKg: quantity,
        neonatesAdded: neonates,
        status: _status,
        notes: notes.isEmpty ? null : notes,
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save batch. Please try again.')),
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
            _buildPageHeader(context, 'Edit batch', 'Changes sync to your server'),
            const SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Batch number'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _wasteController,
              decoration: const InputDecoration(labelText: 'Waste type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity (KG)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _neonatesController,
              decoration: const InputDecoration(labelText: 'Neonates added'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 2,
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