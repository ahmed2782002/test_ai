import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class NavBarShapePainter extends CustomPainter {
  final double fabCenterY;
  final double notchRadius;
  final double cornerRadius;

  const NavBarShapePainter({required this.fabCenterY, required this.notchRadius, required this.cornerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final host = Offset.zero & size;
    final guest = Rect.fromCircle(center: Offset(size.width / 2, fabCenterY), radius: notchRadius);
    final notched = const CircularNotchedRectangle().getOuterPath(host, guest);
    final rounded = Path()
      ..addRRect(RRect.fromRectAndCorners(host, topLeft: Radius.circular(cornerRadius), topRight: Radius.circular(cornerRadius)));
    final shape = Path.combine(PathOperation.intersect, notched, rounded);
    canvas.drawShadow(shape, AppColors.navShadow, 10, false);
    canvas.drawPath(shape, Paint()..color = AppColors.white);
  }

  @override
  bool shouldRepaint(NavBarShapePainter oldDelegate) {
    return oldDelegate.fabCenterY != fabCenterY || oldDelegate.notchRadius != notchRadius || oldDelegate.cornerRadius != cornerRadius;
  }
}
