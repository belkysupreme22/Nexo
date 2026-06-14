import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  static const card = [
    BoxShadow(color: Color(0x38000000), blurRadius: 24, offset: Offset(0, 14)),
  ];

  static const glow = [
    BoxShadow(
      color: AppColors.accentDeep,
      blurRadius: 28,
      offset: Offset(0, 10),
      spreadRadius: -18,
    ),
  ];
}
