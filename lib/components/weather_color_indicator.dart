import 'package:flutter/material.dart';

Color getDotColor(double value, String param) {
  switch (param) {
    case 'wind':
      if (value < 10) {
        return Colors.green;
      } else if (value < 20) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    case 'humidity':
      if (value < 40) {
        return Colors.green;
      } else if (value < 70) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    case 'visibility':
      if (value >= 10) {
        return Colors.green;
      } else if (value >= 5) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    case 'cloud':
      if (value < 30) {
        return Colors.green;
      } else if (value < 60) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    case 'moon_illumination':
      if (value < 10) {
        return Colors.green;
      } else if (value < 80) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    case 'temp':
      if (value < 16) {
        return Colors.blue;  // Froid
      } else if (value < 25) {
        return Colors.green;  // Tempéré
      } else {
        return Colors.red;  // Chaud
      }
    case 'precipitation': // en mm
      if (value < 1) {
        return Colors.green;
      } else if (value < 5) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    default:
      return Colors.grey;
  }
}
