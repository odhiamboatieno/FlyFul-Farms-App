import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 460;

        if (isDesktop) {
          return _buildDesktopFrame(constraints, child);
        }
        return _buildMobile(child);
      },
    );
  }

  Widget _buildDesktopFrame(BoxConstraints constraints, Widget child) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, 0.42),
          radius: 0.5,
          colors: [Color(0xFFF7FAF7), Color(0xFFE1EBE3), Color(0xFFCAD9CD)],
        ),
      ),
      child: Center(
        child: Container(
          width: 440,
          height: constraints.maxHeight - 64,
          decoration: BoxDecoration(
            color: AppColors.paper,
            borderRadius: BorderRadius.circular(52),
            border: Border.all(color: const Color(0xFF171B18), width: 9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 78,
                offset: const Offset(0, 38),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 32,
                  margin: const EdgeInsets.only(top: 0, left: 50, right: 50),
                  decoration: const BoxDecoration(
                    color: Color(0xFF080A09),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(19),
                      bottomRight: Radius.circular(19),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 11,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 38,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3C443F),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(42),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobile(Widget child) {
    return child;
  }
}
