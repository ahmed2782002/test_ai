import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_outlined_button/app_outlined_button.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';
import '../../view_model/spin_wheel_cubit.dart';
import '../../view_model/spin_wheel_state.dart';
import '../widgets/spin_wheel/spin_wheel.dart';
import '../widgets/spin_wheel_background.dart';
import '../widgets/spin_wheel_header.dart';

class SpinWheelScreen extends StatelessWidget {
  const SpinWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpinWheelCubit(),
      child: BlocConsumer<SpinWheelCubit, SpinWheelState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final cubit = context.read<SpinWheelCubit>();
          if (state.status == SpinWheelStatus.won && cubit.wonPrize != null) {
            final prize = cubit.wonPrize!.titleKey.tr().replaceAll('\n', ' ');
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('spin_wheel.won'.tr(args: [prize]))));
          }
          if (state.status == SpinWheelStatus.useLater) Navigator.of(context).maybePop();
        },
        builder: (context, state) {
          final cubit = context.read<SpinWheelCubit>();
          return Scaffold(
            backgroundColor: AppColors.spinBackground,
            body: Stack(
              children: [
                const Positioned.fill(child: SpinWheelBackground()),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 112.h),
                        SpinWheelHeader(title: 'spin_wheel.title'.tr(), subtitle: 'spin_wheel.subtitle'.tr()),
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
            ),
          );
        },
      ),
    );
  }
}
