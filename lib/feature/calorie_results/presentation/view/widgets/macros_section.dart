import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../mock_model/calorie_results_model.dart';
import 'macro_nutrient_card.dart';

class MacrosSection extends StatelessWidget {
  final List<MacroNutrient> macros;

  const MacrosSection({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('calorie_results.macros'.tr(context: context), style: AppText.sectionTitle),
        SizedBox(height: 14.h),
        for (final macro in macros) ...[
          MacroNutrientCard(macro: macro),
          SizedBox(height: 12.h),
        ],
      ],
    );
  }
}
