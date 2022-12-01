import 'package:dart_prodata_util/src/models/util-theme.dart';
import 'package:flutter/material.dart';

enum DeviceType { extraSmall, small, medium, large, extraLarge }

class ProConfig {
  /// Define configurações padrões para o aplicativo.

  static double screenWidth = 0;
  static double screenHeight = 0;
  static double bodyHeight = 0;
  static String baseUrl = '';
  static String baseUrlImagem = '';

  static DeviceType deviceType = DeviceType.small;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static late UtilTheme utilTheme;

  /// Retorna o [BuildContext] atual.
  static BuildContext get currentContext {
    assert(navigatorKey.currentContext != null, 'Context não encontrado. Verifique se a navigatorKey está definida no MaterialApp.');
    return navigatorKey.currentContext!;
  }

  /// Inicia configuração.
  static void initConfig(BuildContext context, {String baseURL = '', String baseUrlImage = ''}) {
    baseUrl = baseURL;
    baseUrlImagem = baseUrlImage;

    if (screenHeight <= 0) {
      updateScreenSize(context);
    }
    utilTheme = UtilTheme(context);
  }

  /// Atualizada dados das dimensões da tela.
  static updateScreenSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    // Tamanho total da área de tela descontando a appBar e a StatusBar
    bodyHeight = size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;

    if(size.longestSide <= 575.98) {
      deviceType = DeviceType.extraSmall;
    } else if(size.shortestSide >= 576 && size.longestSide <= 767.98) {
      deviceType = DeviceType.small;
    } else if(size.shortestSide >= 768 && size.longestSide <= 991.98) {
      deviceType = DeviceType.medium;
    } else if(size.shortestSide >= 992 && size.longestSide <= 1999.98) {
      deviceType = DeviceType.large;
    } else { // (shortestSide >= 1200)
      deviceType = DeviceType.extraLarge;
    }
  }

  /// Retorna um [double] baseado no [DeviceType].
  static double choseSize(double sm, [double? md, double? lg]) {
    md = md == null || md == 0 ? sm : md;
    lg = lg == null || lg == 0 ? md : lg;

    switch(deviceType) {
      case DeviceType.extraSmall:
      case DeviceType.small:
        return sm;
      case DeviceType.medium:
        return md;
      case DeviceType.large:
      case DeviceType.extraLarge:
        return lg;
    }
  }

  /// Retorna um [Size] baseado na porcentagem informada e o [DeviceType].
  static Size getSize(double percent) {
    final screenSize = MediaQuery.of(currentContext).size;
    return Size(screenSize.width*percent, screenSize.height*percent);
  }
}