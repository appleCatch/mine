/*
以http开头的网络页面
 */
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mine/commons/constants.dart';
import 'package:mine/config/colors.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final dynamic params;

  WebViewPage(this.url, {Key key, this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: Text(params[Constant.TITLE_NAME]),
        backgroundColor: ColorConfig.defaultColor,
      ),
    );
  }
}
