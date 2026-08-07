import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildPageHeader(context, 'Cages', 'Look after the cages'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 39, height: 39, decoration: BoxDecoration(color: AppColors.pale, borderRadius: BorderRadius.circular(5)),
                    child: Icon(FontAwesomeIcons.warehouse.data, color: AppColors.green, size: 20)),
                  const SizedBox(width: 8),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const OutfitText(text: 'Cage A', fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink),
                    Text('Maintenance log', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ])),
                ]),
                const SizedBox(height: 8),
                Text('Last maintenance: 3 days ago', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ]),
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
