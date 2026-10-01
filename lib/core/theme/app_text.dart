import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract final class AppText {
  static const String fontFamily = 'Noto Sans Arabic';

  static TextStyle get headerTitle => TextStyle(
    fontSize: 20.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static TextStyle get subtitle => TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  static TextStyle get sectionTitle => TextStyle(
    fontSize: 18.sp,
    height: 1.44,
    fontWeight: FontWeight.w600,
    color: AppColors.textTitle,
  );

  static TextStyle get packagesTitle => TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get cardTitle => TextStyle(
    fontSize: 18.sp,
    height: 1.55,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get label => TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get unit => TextStyle(
    fontSize: 14.sp,
    height: 1.43,
    fontWeight: FontWeight.w400,
    color: AppColors.textUnit,
  );

  static TextStyle get counterValue => TextStyle(
    fontSize: 18.sp,
    height: 1.55,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get option => TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w500,
    color: AppColors.optionText,
  );

  static TextStyle get optionTitle => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.textTitle,
  );

  static TextStyle get optionTitleSelected => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle get button => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle get caption => TextStyle(
    fontSize: 13.sp,
    height: 1.54,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted.withValues(alpha: 0.8),
  );

  static TextStyle get homeGreeting => TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get homeHeadline => TextStyle(
    fontSize: 18.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static TextStyle get homeTitle => TextStyle(
    fontSize: 16.sp,
    height: 1.5,
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static TextStyle get mealTitle => TextStyle(
    fontSize: 16.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get homeTitleSmall => TextStyle(
    fontSize: 13.sp,
    height: 1.6,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle get homeLabel => TextStyle(
    fontSize: 14.sp,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get quickActionLabel => TextStyle(
    fontSize: 14.88.sp,
    height: 1.5,
    fontWeight: FontWeight.w600,
    color: AppColors.textTitle,
  );

  static TextStyle get navLabel => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.navLabel,
  );

  static TextStyle get link => TextStyle(
    fontSize: 14.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static TextStyle get mealAction => TextStyle(
    fontSize: 13.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static TextStyle get accentTitle => TextStyle(
    fontSize: 13.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static TextStyle get accentCaption => TextStyle(
    fontSize: 11.sp,
    height: 1.4,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static TextStyle get price => TextStyle(
    fontSize: 14.sp,
    height: 1.4,
    fontWeight: FontWeight.w800,
    color: AppColors.accent,
  );

  static TextStyle get homeBody => TextStyle(
    fontSize: 12.sp,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textGray,
  );

  static TextStyle get searchHint => TextStyle(
    fontSize: 14.sp,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.searchHint,
  );

  static TextStyle get grayCaption => TextStyle(
    fontSize: 12.sp,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textGray,
  );

  static TextStyle get packageDuration => TextStyle(
    fontSize: 11.sp,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textGray,
  );

  static TextStyle get mutedCaption => TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle get highlightTitle => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
  );

  static TextStyle get highlightValue => TextStyle(
    fontSize: 28.sp,
    height: 1.29,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.textTitle,
  );

  static TextStyle get valueBold => TextStyle(
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static TextStyle get tag => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryDark,
  );

  static TextStyle get packageTitle => TextStyle(
    fontSize: 20.sp,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.textTitle,
  );

  static TextStyle get packagePrice => TextStyle(
    fontSize: 24.sp,
    height: 1.33,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle get currency => TextStyle(
    fontSize: 15.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryDark,
  );

  static TextStyle get description => TextStyle(
    fontSize: 13.sp,
    height: 1.54,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle get spinTitle => TextStyle(
    fontSize: 28.sp,
    height: 1.29,
    fontWeight: FontWeight.w700,
    color: AppColors.stepsAccent,
  );

  static TextStyle get spinSubtitle => TextStyle(
    fontSize: 28.sp,
    height: 1.29,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle get wheelLabel => TextStyle(
    fontSize: 13.sp,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.wheelLabel,
  );

  static TextStyle get buttonBold => TextStyle(
    fontSize: 20.sp,
    height: 1.19,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get outlinedButton => TextStyle(
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryDark,
  );

  static TextStyle get cinemaName => TextStyle(
    fontSize: 14.sp,
    height: 1.17,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get cinemaDescription => TextStyle(
    fontSize: 12.sp,
    height: 1.17,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get cinemaReviewLabel => TextStyle(
    fontSize: 18.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: AppColors.cinemaTextSoft,
  );

  static TextStyle get cinemaRating => TextStyle(
    fontSize: 14.sp,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.cinemaTextSoft,
  );

  static TextStyle get cinemaRatingCount => TextStyle(
    fontSize: 14.sp,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.cinemaTextMuted,
  );

  static TextStyle get cinemaSectionTitle => TextStyle(
    fontSize: 26.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: AppColors.cinemaSectionTitle,
  );

  static TextStyle get cinemaSectionTitleLight => TextStyle(
    fontSize: 26.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get movieTitle => TextStyle(
    fontSize: 18.sp,
    height: 1.1,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get movieInfo => TextStyle(
    fontSize: 13.sp,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get commentUsername => TextStyle(
    fontSize: 14.sp,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get commentBody => TextStyle(
    fontSize: 12.sp,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get commentField => TextStyle(
    fontSize: 14.sp,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.cinemaHint,
  );
}
