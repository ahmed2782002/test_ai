import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../view_model/spin_wheel_cubit.dart';
import '../../view_model/spin_wheel_state.dart';
import '../widgets/spin_wheel_body.dart';

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
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.spinBackground,
          body: SpinWheelBody(state: state),
        ),
      ),
    );
  }
}
