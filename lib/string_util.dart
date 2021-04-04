import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class StringUtil {
  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split('').map((l) => l[0]).take(2).join()
      : '';

  static String dateNow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String formatString(String date) {
    initializeDateFormatting();
    DateTime fromDate = DateTime.parse(date);
    var formatter = new DateFormat.yMMMMd("id_ID");
    String formatted = formatter.format(fromDate);
    return formatted;
  }

  static String completeDateNow() {
    initializeDateFormatting();
    var today = DateTime.now();
    String formattedDate = DateFormat("EEEE, dd MMMM y", 'id').format(today);
    return formattedDate;
  }

  static String completeDateTimeNow() {
    initializeDateFormatting();
    var today = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(today);
    return formattedDate;
  }

  static String hourMinuteNow() {
    initializeDateFormatting();
    var today = DateTime.now();
    String formattedDate = DateFormat("Hms").format(today);
    return formattedDate;
  }
  
  static String convertBoolToString(value) {
    if (value is bool) {
      return value.toString();
    }else {
      return value;
    }
  }

}
