import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';

class LabeledFieldRow extends StatelessWidget {
  final String label;
  final String? unit;
  final Widget child;

  const LabeledFieldRow({
    super.key,
    required this.label,
    this.unit,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74.w,
          child: Text.rich(
            TextSpan(
              text: label,
              style: AppText.label,
              children: [
                if (unit != null) TextSpan(text: unit, style: AppText.unit),
              ],
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
