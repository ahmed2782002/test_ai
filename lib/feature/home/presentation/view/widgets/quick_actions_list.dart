import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mock_model/quick_action_type.dart';
import 'quick_action_item.dart';

class QuickActionsList extends StatelessWidget {
  final List<QuickActionType> actions;
  final ValueChanged<QuickActionType> onActionTap;

  const QuickActionsList({super.key, required this.actions, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < actions.length; index++)
            Padding(
              padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 8.w),
              child: QuickActionItem(
                icon: actions[index].icon,
                iconHeight: actions[index].iconHeight,
                label: context.tr(actions[index].translationKey),
                onTap: () => onActionTap(actions[index]),
              ),
            ),
        ],
      ),
    );
  }
}
