import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/widgets/app_outlined_button/app_outlined_button.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';
import '../../view_model/spin_wheel_cubit.dart';
import '../../view_model/spin_wheel_state.dart';
import 'spin_wheel/spin_wheel.dart';

class SpinWheelBody extends StatelessWidget {
  final SpinWheelState state;

  const SpinWheelBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpinWheelCubit>();
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(AppImages.spinWheelBackground, fit: BoxFit.cover)),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 112.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🎁', style: AppText.spinTitle),
                    SizedBox(width: 8.w),
                    Flexible(child: Text('spin_wheel.title'.tr(), textAlign: TextAlign.center, style: AppText.spinTitle)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text('spin_wheel.subtitle'.tr(), textAlign: TextAlign.center, style: AppText.spinSubtitle),
                SizedBox(height: 54.h),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SpinWheel(
                        prizes: cubit.prizes,
                        turns: state.turns,
                        spinDuration: SpinWheelCubit.spinDuration,
                        onSpinEnd: cubit.completeSpin,
                        onHubTap: cubit.spin,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: 'spin_wheel.spin_now'.tr(),
                  textStyle: AppText.buttonBold,
                  trailingIcon: AppIcons.chevronForward,
                  trailingIconSize: 10.r,
                  borderRadius: 10.59.r,
                  shadow: AppShadows.option,
                  onPressed: cubit.spin,
                ),
                SizedBox(height: 8.h),
                AppOutlinedButton(text: 'spin_wheel.use_later'.tr(), onPressed: cubit.useLater),
                SizedBox(height: 33.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
