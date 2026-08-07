import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/shared/widgets/bottom_nav.dart';

class BatchListPage extends StatefulWidget {
  const BatchListPage({super.key});

  @override
  State<BatchListPage> createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  final _searchController = TextEditingController();
  int _currentIndex = 1;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPageHeader(context, 'My batches', 'Tap a batch to see its work'),
              const SizedBox(height: 16),
              _buildSearchField(),
              const SizedBox(height: 22),
              _buildBatch('BSF-2026-012', 'Vegetables · Day 3', Icons.eco, AppColors.green, 'Feed'),
              const SizedBox(height: 9),
              _buildBatch('BSF-2026-007', 'Market waste · Day 14', Icons.shopping_basket, AppColors.orange, 'Harvest'),
              const SizedBox(height: 9),
              _buildBatch('BSF-2026-009', 'Kitchen waste · Day 8', Icons.food_bank, AppColors.green, 'Growing'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i)),
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

  Widget _buildSearchField() {
    return Container(
      height: 58,
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: _searchController,
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

  Widget _buildBatch(String number, String subtitle, IconData icon, Color tagColor, String tag) {
    return Container(
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
    );
  }
}
