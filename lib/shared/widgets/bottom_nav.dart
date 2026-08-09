import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavBar({super.key, this.currentIndex = 0, this.onTap});

  static const _routes = ['/today', '/batches', '/record', '/cages', '/farm'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.only(
        top: 9,
        left: 14,
        right: 14,
        bottom: 9,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, Icons.wb_sunny_outlined, 'Today', 0),
              _buildNavItem(context, Icons.layers_outlined, 'Batches', 1),
              const SizedBox(width: 74),
              _buildNavItem(context, Icons.warehouse_outlined, 'Cages', 3),
              _buildNavItem(context, Icons.eco_outlined, 'My farm', 4),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -21,
            child: Center(
              child: SizedBox(
                width: 64,
                height: 64,
                child: FloatingActionButton(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () => _onTap(context, 2),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 21),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 21,
            color: isActive ? AppColors.green : AppColors.muted,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.green : AppColors.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }
    context.go(_routes[index]);
  }
}
