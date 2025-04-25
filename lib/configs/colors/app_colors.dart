import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryColor = Color(0xFF007EF2);
  static const Color primaryColor2 = Color(0xFF008CFF);
  static const Color secondaryColor = Color(0xFF00D4FF);
  static const Color buttonColor = Color(0xFF007AFF);
  static const Color whiteColor = Color(0xFFFFFEFF);
  static const Color blackColor = Colors.black;
  static const Color lightColor = Color(0xFF667185);
  static const Color mediumColor = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFCBD5E1);
  static const Color focusBorderColor = Color(0xFF1D4ED8);
  static const Color errorColor = Color(0xFFD23A35);
  static const Color successColor = Color(0xFF128E42);
  static const Color darkColor = Color(0xFF334155);
  static const Color yellowColor = Color(0xFFEECB41);
  static const Color yellowColor2 = Color(0xFFFFC500);
  static const Color greenColor = Color(0xFF54E283);
  static const Color greenColor2 = Color(0xFF34A853);
  static const Color redColor = Color(0xFFEB4335);
  static const Color oneRule = Color(0xFFE7ECFB);
  static const Color bgColor = Color(0xFFE9EEF3);

  static const LinearGradient gradientColor = LinearGradient(
    colors: [
      Color(0xFF007AFF), // Deep Blue (top)
      Color(0xFF00C6FB), // Light Cyan (bottom)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient gradientColor2 = LinearGradient(
    colors: [
      Color(0xFF007AFF), // Deep Blue (top)
      Color(0xFF008CFF), // Deep Blue (top)
      Color(0xFF00C6FB), // Light Cyan (bottom)
    ],
    begin: Alignment.topLeft,
    // stops: [0.1, 0.5, 0.9],
    end: Alignment.topRight,
  );
}
