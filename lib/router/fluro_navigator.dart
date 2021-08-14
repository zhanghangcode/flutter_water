import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_water/router/routers.dart';



/// Fluroのルーティング遷移ツールクラス
class NavigatorUtils {
  
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routes.router.navigateTo(context, path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    );
  }

  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routes.router.navigateTo(context, path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    ).then((Object? result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 戻る
  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// パラメータを付けて返す
  static void goBackWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }
  
  /// WebViewページにジャンプします
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 漢字をサポートしていません。変換する必要があります
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unfocus() {
    // 次の方法を使用すると、不要なビルドがトリガーされます。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
