import 'package:intl/intl.dart' show DateFormat, NumberFormat;

class Formatter {
  /// Converte um [double] para um formato [String] no padrão da moeda brasileira.
  ///
  /// Ex: R$ 35,00
  static String moneyFormat(double value) {
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return 'R\$ ${formatter.format(value)}';
  }

  /// Converte um [double] para um formato [String] no padrão de porcentagem.
  ///
  /// Ex: 99%
  static String percentFormat(double value) {
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return '${formatter.format(value)} %';
  }

  /// Converte um [DateTime] para um formato [String] no padrão de data dd/MM/yyyy.
  ///
  /// Ex: 01/01/2012
  static String datePtBr(DateTime value) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(value);
  }
  /// Converte um [DateTime] para um formato [String] no padrão de data e hora dd/MM/yyyy HH:mm:ss.
  ///
  /// Ex: 01/01/2012 23:59:35
  static String dateTimePtBr(DateTime value) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(value);
  }

  /// Converte um [DateTime] para o formato [String] informado.
  static String dateCustomFormat(DateTime value, String format) {
    final formatter = DateFormat(format);
    return formatter.format(value);
  }

  /// Converte uma [String] para um formato [String] no padrão de CEP.
  ///
  /// Ex: 25.600-415
  static String cepFormat(String value) {
    value = removeSpecialChars(value);
    assert(value.length == 8);

    return '${value.substring(0,2)}.${value.substring(2,5)}-${value.substring(5)}';
  }

  /// Converte a primeira letra de cada palavra de uma [String] para maiúsculo.
  ///
  /// Exceções: do|dos|da|das|de|e
  static String capitalize(String value) {
    const String wordExcluded = '|do|dos|da|das|de|e|';
    String capitalizeFirstOfEach = (value).split(' ').map((str) => wordExcluded.contains(str.toLowerCase()) ? str.toLowerCase() : inCaps(str)).join(' ');
    return capitalizeFirstOfEach;
  }

  /// Converte a primeira letra de uma [String] para maiúsculo.
  static String inCaps(String value) {
    String inCaps = value.isNotEmpty ? '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}' : '';
    return inCaps;
  }

  /// Remove todos os caracteres especiais de uma [String], mantendo apenas letras e algarismos.
  static String removeSpecialChars(String value) {
    assert(value.isNotEmpty);
    return value.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }
}