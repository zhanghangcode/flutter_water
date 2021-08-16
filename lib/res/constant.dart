import 'package:flutter/foundation.dart';

class Constant {

  /// アプリがリリース環境で実行されている場合、inProductionはtrueです。
  /// アプリがデバッグおよびプロファイル環境で実行されている場合、inProductionはfalseです。
  static const bool inProduction  = kReleaseMode;

  static bool isDriverTest  = false;
  static bool isUnitTest  = false;
  
  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
  
  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

}