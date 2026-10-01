import 'package:flutter/material.dart';

import '../../../../../core/utils/app_images.dart';

class SpinWheelBackground extends StatelessWidget {
  const SpinWheelBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.spinWheelBackground, fit: BoxFit.cover);
  }
}
