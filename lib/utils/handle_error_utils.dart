import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_water/res/constant.dart';

/// グローバル例外をキャッチし、統合処理を実行します。
void handleError(void body) {
  /// Flutter例外コールバックをオーバーライドしますFlutterError.onError
  FlutterError.onError = (FlutterErrorDetails details) {
    if (!Constant.inProduction) {
      // デバッグするときは、例外情報を直接出力
      FlutterError.dumpErrorToConsole(details);
    } else {
      // rリリース中、例外はゾーンによって統一された方法で処理されます。
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  /// runZonedGuardedを使用して、Flutterで捕捉されなかった例外をキャッチします
  runZonedGuarded(() => body, (Object error, StackTrace stackTrace) async {
    await _reportError(error, stackTrace);
  });

}

Future<void> _reportError(Object error, StackTrace stackTrace) async {

  if (!Constant.inProduction) {
    debugPrintStack(
      stackTrace: stackTrace,
      label: error.toString(),
      maxFrames: 100,
    );
  } else {
    /// 例外情報を収集してサーバーにアップロードします。
    /// `flutter_bugly`に似たプラグインを直接使用して、例外レポートを処理できます。
  }

}