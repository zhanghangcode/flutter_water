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
      // ページは結果をnullとして返します
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


  static void unfocus() {
    // 次の方法を使用すると、不要なビルドがトリガーされます。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
