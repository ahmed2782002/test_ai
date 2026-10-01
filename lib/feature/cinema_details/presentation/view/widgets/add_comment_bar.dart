import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';

class AddCommentBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onSend;

  const AddCommentBar({super.key, required this.controller, required this.hint, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(26.w, 8.h, 35.w, 4.h + MediaQuery.paddingOf(context).bottom),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 36.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cinemaField,
                borderRadius: BorderRadius.circular(AppRadius.compact),
                boxShadow: AppShadows.cinemaField,
              ),
              child: TextField(
                controller: controller,
                style: AppText.commentField,
                cursorColor: AppColors.white,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: AppText.commentField,
                  contentPadding: EdgeInsetsDirectional.only(start: 20.w, end: 12.w),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          IconButton(
            onPressed: onSend,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 28.r, height: 28.r),
            icon: Icon(AppIcons.send, size: 28.r, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
