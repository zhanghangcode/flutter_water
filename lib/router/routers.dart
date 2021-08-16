import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_water/home/home.dart';


class Routes {

  static String home = '/home';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {


    router.define(home, handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) => const Home()));


    _listRouter.clear();
    /// それぞれのルートはそれぞれのモジュールによって管理され、
    /// 初期化はここに一律に追加されます

  
    /// ルーティングを初期化する
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

abstract class IRouterProvider {

  void initRouter(FluroRouter router);
}
