import 'package:flutter/material.dart';

class UIHelper {
  // Spacing
  static const EdgeInsets paddingAll16 = EdgeInsets.all(16.0);
  static const SizedBox verticalSpace16 = SizedBox(height: 16);
  static const SizedBox verticalSpace8 = SizedBox(height: 8);

  // Text Styles
  static TextStyle headingStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF333333),
  );

  static TextStyle noteTitleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2F2F2F),
  );

  static TextStyle noteContentStyle = const TextStyle(
    fontSize: 14,
    color: Color(0xFF555555),
  );

  static BorderRadius cardRadius = BorderRadius.circular(12);
}
