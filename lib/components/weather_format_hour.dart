import 'package:intl/intl.dart';

String formatHourWithSuffix(DateTime time) {
  String hour = DateFormat('H').format(time);
  String minute = DateFormat('mm').format(time);

  if (minute == '00') {
    return '${hour}H';
  } else {
    return '${hour}H$minute';
  }
}
