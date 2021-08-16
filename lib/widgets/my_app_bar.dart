
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_water/res/colors.dart';
import 'package:flutter_water/res/dimens.dart';
import 'package:flutter_water/res/gaps.dart';

import 'my_button.dart';

/// カスタマイズAppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName = '',
    this.backImgColor,
    this.onPressed,
    this.onPressedData,
    this.isBack = true,
    this.isBackData = false,
  }) : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final Color? backImgColor;
  final String actionName;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedData;
  final bool isBack;
  final bool isBackData;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Colours.app_main;

    final SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            onPressed:
            isBackData
                ? onPressedData
                : () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final isBack = await Navigator.maybePop(context);
                    if (!isBack) {
                      await SystemNavigator.pop();
                    }
                  },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          )
        : Gaps.empty;

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: MyButton(
                key: const Key('actionName'),
                fontSize: Dimens.font_sp14,
                minWidth: null,
                text: actionName,
                textColor: Colors.white,
                backgroundColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style:
              const TextStyle(fontSize: Dimens.font_sp18, color: Colors.white),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
