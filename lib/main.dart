import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_water/home/home.dart';
import 'package:flutter_water/login/page/login_page.dart';
import 'package:flutter_water/provider/locale_provider.dart';
import 'package:flutter_water/provider/theme_provider.dart';
import 'package:flutter_water/router/routers.dart';
import 'package:flutter_water/utils/device_utils.dart';
import 'package:flutter_water/utils/handle_error_utils.dart';
import 'package:flutter_water/utils/log_utils.dart';
import 'package:flutter_water/utils/theme_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';


Future<void> main() async {

//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;

  /// 初期化が完了していることを確認
  WidgetsFlutterBinding.ensureInitialized();


  /// sp初期化
  await SpUtil.getInstance();

  /// 异常处理
  handleError(runApp(MyApp()));

}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.home, this.theme}) : super(key: key) {
    Log.init();
    Routes.initRoutes();
  }

  final Widget? home;
  final ThemeData? theme;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider())
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
          return _buildMaterialApp(provider, localeProvider);
        },
      ),
    );

    /// Toast 配置
    return OKToast(
        child: app,
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom
    );
  }

  Widget _buildMaterialApp(ThemeProvider provider, LocaleProvider localeProvider) {
    return MaterialApp(
      title: 'Flutter Water',
      // showPerformanceOverlay: true, //显示性能标签
      // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
      // checkerboardRasterCacheImages: true,
      // showSemanticsDebugger: true, // 显示语义视图
      // checkerboardOffscreenLayers: true, // 检查离屏渲染
      theme: theme ?? provider.getTheme(),
      darkTheme: provider.getTheme(isDarkMode: true),
      themeMode: provider.getThemeMode(),
      home: home ?? const LoginPage(),
      onGenerateRoute: Routes.router.generator,
      // localizationsDelegates: DeerLocalizations.localizationsDelegates,
      // supportedLocales: DeerLocalizations.supportedLocales,
      locale: localeProvider.locale,
      navigatorKey: navigatorKey,
      builder: (BuildContext context, Widget? child) {
        /// アンドロイドのみ
        if (Device.isAndroid) {
          /// ダークモードに切り替えると、このメソッドがトリガーされます。ここで、ナビゲーションバーの色を設定します
          ThemeUtils.setSystemNavigationBar(provider.getThemeMode());
        }

        /// テキストサイズが電話システムの設定の影響を受けないことを確認する https://www.kikt.top/posts/flutter/layout/dynamic-text/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },


      restorationScopeId: 'app',
    );
  }
}
