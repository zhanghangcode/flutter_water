import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_water/home/home.dart';


class Routes {

  static String home = '/home';
  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    // router.notFoundHandler = Handler(
    //   handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    //     debugPrint('未找到目标页');
    //     return const NotFoundPage();
    //   });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) => const Home()));
    
    // router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
    //   final String title = params['title']?.first ?? '';
    //   final String url = params['url']?.first ?? '';
    //   return WebViewPage(title: title, url: url);
    // }));

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
