import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:mine/pages/splash_widget.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // android 头部导航栏设置为透明
    SystemUiOverlayStyle style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.white),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          /// 启动欢迎页面
          body: SplashWidget(),
        ),
      ),
    );
  }
}


class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({Key key, @required this.child}):
      assert(child != null),
      super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }

  static restartApp(BuildContext context) {
    _RestartWidgetState state = context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }
}

class _RestartWidgetState extends State<RestartWidget> {

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}