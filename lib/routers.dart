/*
整体的路由配置模块
 */

import 'package:flutter/material.dart';

import 'package:mine/pages/web_view_page.dart';
import 'package:mine/pages/container_page.dart';
import 'package:mine/pages/upload/upload_page.dart';
import 'package:mine/pages/search/search_page.dart';
import 'package:mine/config/colors.dart';

class Router {
  // 主页
  static const homePage = 'mine://';
  // 告白
  static const confessionPage = 'mine://confessionPage';
  // 图片集
  static const imagesPage = 'mine://imagesPage';
  // 视频集
  static const videosPage = 'mine://videosPage';
  // 我们的日子
  static const mineDailyPage = 'mine://mineDailyPage';
  // 全局搜索
  static const searchPage = 'mine://searchPage';
  // 上传文件
  static const uploadFile = 'mine://uploadFile';


  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('http')) return WebViewPage(url, params: params,);
    else {
      switch (url) {
        /// 首页处理整体的容器布局
        case homePage: return MainContainer();
        case uploadFile: return UploadPage();
        case searchPage: return SearchPage();
      }
    }
    return SafeArea(
      child: Center(
        child: Text('route error, not page relative found !',
          style: TextStyle(
            color: ColorConfig.defaultBlue,
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),
        ),
      ),
    );
  }

  /// 无参数页面跳转
  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  /// 有参数页面跳转
  Router.pushWithParams(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }

}
