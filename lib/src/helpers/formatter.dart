import 'package:intl/intl.dart' show DateFormat, NumberFormat;

class Formatter {
  static String moneyFormat(double value) {
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return 'R\$ ${formatter.format(value)}';
  }

  static String percentFormat(double value) {
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return '${formatter.format(value)} %';
  }

  static String datePtBr(DateTime value) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(value);
  }

  static String dateTimePtBr(DateTime value) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(value);
  }

  static String dateCustomFormat(DateTime value, String format) {
    final formatter = DateFormat(format);
    return formatter.format(value);
  }

  static String cepFormat(String value) {
    value = removeSpecialChars(value);
    assert(value.length == 8);

    return '${value.substring(0,2)}.${value.substring(2,5)}-${value.substring(5)}';
  }

  static String capitalize(String value) {
    const String wordExcluded = '|do|dos|da|das|de|e|';
    String capitalizeFirstofEach = (value).split(' ').map((str) => wordExcluded.contains(str.toLowerCase()) ? str.toLowerCase() : inCaps(str)).join(' ');
    return capitalizeFirstofEach;
  }

  static String inCaps(String value) {
    String inCaps = value.isNotEmpty ? '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}' : '';
    return inCaps;
  }

  static String removeSpecialChars(String value) {
    assert(value.isNotEmpty);
    return value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }
}