/*
分辨率相关工具类
 */
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

void setDesignWHD(double w, double h, {double d = 3.0}) {
  _designW = w;
  _designH = h;
  _designD = d;
}

class ScreenUtil {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;

  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;

  MediaQueryData _mediaQueryData;

  static final ScreenUtil _singleton = ScreenUtil();

  static ScreenUtil getInstance() {
    _singleton._init();
    return _singleton;
  }

  _init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _screenDensity = mediaQuery.devicePixelRatio;

      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = mediaQuery.padding.bottom;
      _appBarHeight = kToolbarHeight;
    }
  }

  // 定义get方法

  double get screenWidth => _screenWidth;

  double get screenHeitht => _screenHeight;

  double get screenDensity => _screenDensity;

  double get statusBarHeight => _statusBarHeight;

  double get bottomBarHeight => _bottomBarHeight;

  double get appBarHeight => _appBarHeight;

  MediaQueryData get mediaQueryData => _mediaQueryData;

  // 定义获取当前屏幕的宽高分辨率等信息

  static double screenW(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.width;
  }

  static double screenH(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.height;
  }

  static double screenD(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.devicePixelRatio;
  }

  static double statusBarH(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.padding.top;
  }

  static double bottomBarH(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.padding.bottom;
  }

  static MediaQueryData curMediaQueryData(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData;
  }

  // 对屏幕尺寸适配后的调整, 返回根据屏幕高适配后尺寸
  static double scaleW(BuildContext context, double size) {
    if (null == context || screenW(context) == 0.0) return size;
    return size * screenW(context) / _designW;
  }

  static double scaleH(BuildContext context, double size) {
    if (null == context || screenH(context) == 0.0) return size;
    return size * screenH(context) / _designH;
  }

  // 返回根据屏幕适配后的字体的尺寸
  static double scaleFontSize(BuildContext context, double fontSize) {
    if (null == context || screenD(context) == 0.0) return fontSize;
    return fontSize * screenW(context) / _designW;
  }

  // 返回设备方向
  static Orientation getOrientation(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return data.orientation;
  }

  // 根据屏幕的宽和高适配
  double widthBased(double size) {
    return _screenWidth == 0.0 ? size : size * _screenWidth / _designW;
  }

  double heightBased(double size) {
    return _screenHeight == 0.0 ? size : size * _screenHeight / _designH;
  }

  double widthPxBased(double sizePx) {
    return _screenWidth == 0.0
        ? sizePx / _designD
        : (sizePx * _screenWidth / (_designW * _designD));
  }

  double heightPxBased(double sizePx) {
    return _screenHeight == 0.0
        ? sizePx / _designD
        : (sizePx * _screenHeight / (_designH * _designD));
  }

  // 根据屏幕宽度适配字体大小
  double fontPxBased(double fontSize) {
    if (_screenDensity==0.0) return fontSize;
    return fontSize * _screenWidth / _designW;
  }
}
