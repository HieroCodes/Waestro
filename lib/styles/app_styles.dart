import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour formater les dates

class AppStyle {
  // Couleurs
  static const Color backgroundColor = Colors.black;
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Colors.white70;
  static const Color dividerColor = Colors.white24;

  // Text styles
  static const TextStyle cityNameStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle tempStyle = TextStyle(
    fontSize: 54,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle realFeelStyle = TextStyle(
    fontSize: 20,
    color: primaryTextColor,
  );

  static const TextStyle dateStyle = TextStyle(
    fontSize: 20,
    color: primaryTextColor,
  );

  static const TextStyle dayTitleStyle = TextStyle(
    fontSize: 18,
    color: primaryTextColor,
  );

  static const TextStyle daySubtitleStyle = TextStyle(
    fontSize: 16,
    color: secondaryTextColor,
  );

  static const TextStyle conditionStyle = TextStyle(
    color: primaryTextColor,
  );

}
