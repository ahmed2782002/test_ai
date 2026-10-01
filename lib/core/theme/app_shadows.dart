import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: AppColors.shadowTitle, offset: Offset(0, 8), blurRadius: 24),
  ];
  static const List<BoxShadow> macroCard = [
    BoxShadow(color: AppColors.shadowTitleSoft, offset: Offset(0, 4), blurRadius: 12),
  ];
  static const List<BoxShadow> infoCard = [
    BoxShadow(color: AppColors.shadowLight, offset: Offset(0, 2), blurRadius: 10),
  ];
  static const List<BoxShadow> option = [
    BoxShadow(color: AppColors.shadowLight, offset: Offset(0, 1), blurRadius: 2),
  ];
  static const List<BoxShadow> bottomBar = [
    BoxShadow(color: AppColors.shadow, offset: Offset(0, -8), blurRadius: 24),
  ];
  static const List<BoxShadow> homeCard = [
    BoxShadow(color: AppColors.shadowCard, offset: Offset(0, 2), blurRadius: 12),
  ];
  static const List<BoxShadow> mutedCard = [
    BoxShadow(color: AppColors.shadowMuted, offset: Offset(0, 8), blurRadius: 24),
  ];
  static const List<BoxShadow> soft = [
    BoxShadow(color: AppColors.shadow, offset: Offset(0, 2), blurRadius: 6),
  ];
  static const List<BoxShadow> navButton = [
    BoxShadow(color: AppColors.shadowButton, offset: Offset(0, 4), blurRadius: 6, spreadRadius: -4),
    BoxShadow(color: AppColors.shadowButton, offset: Offset(0, 10), blurRadius: 15, spreadRadius: -3),
  ];
  static const List<BoxShadow> button = [
    BoxShadow(color: AppColors.shadowButton, offset: Offset(0, 2), blurRadius: 4, spreadRadius: -2),
    BoxShadow(color: AppColors.shadowButton, offset: Offset(0, 4), blurRadius: 6, spreadRadius: -1),
  ];
  static const List<BoxShadow> cinemaField = [
    BoxShadow(color: AppColors.cinemaFieldShadow, offset: Offset(0, 4), blurRadius: 8),
  ];
}
