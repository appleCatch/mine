/*
打开app的欢迎页面
 */

import 'package:flutter/material.dart';
import 'package:mine/commons/constants.dart';
import 'package:mine/pages/container_page.dart';
import 'package:mine/utils/logging_util.dart';
import 'package:mine/utils/screen_util.dart';
import 'dart:async';
import 'package:mine/config/colors.dart';

class SplashWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashWidgetState();
  }
}

class _SplashWidgetState extends State<StatefulWidget> {
  var _logger = Logger('_SplashWidgetState');

  var container = MainContainer();

  bool showCover = true;

  @override
  Widget build(BuildContext context) {
    _logger.log('start to build splashWidget');
    return Stack(
      children: <Widget>[
        Offstage(
          child: container,
          offstage: showCover,
        ),
        Offstage(
          child: Container(
            width: ScreenUtil.screenW(context),
            height: ScreenUtil.screenH(context),
            color: ColorConfig.defaultWhite,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtil.screenW(context) / 3,
                        backgroundColor: ColorConfig.defaultWhite,
                        backgroundImage:
                            AssetImage(Constant.ASSETS_IMG + 'daughter.jpg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '吾家有娇女，皎皎颇白皙.',
                          style: TextStyle(fontSize: 15, color: ColorConfig.defaultBlack),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 30.0, right: 20.0),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 2, bottom: 2.0),

                          child: CountDownWidget(onCountDownFinishCallBack: (value) {
                            if (value) {
                              setState(() {
                                showCover = false;
                              });
                            }
                          },),
                          decoration: BoxDecoration(
                              color: Color(0xffEDEDED),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Constant.ASSETS_IMG + 'daughter.jpg',
                              width: 50,
                              height: 50,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                '亲爱的...',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: ColorConfig.defaultBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          offstage: !showCover,
        ),
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;

  CountDownWidget({Key key, this.onCountDownFinishCallBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountDownState();
  }
}

class _CountDownState extends State<CountDownWidget> {
  var _second = 10;
  Timer _timer;

  @override
  void initState(){
    super.initState();
    _startTimer();
  }

  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
      if (_second < 1) {
        widget.onCountDownFinishCallBack(true);
        _cancelTimer();
        return;
      }
      _second --;
    });
  }

  void _cancelTimer(){
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_second', style: TextStyle(fontSize: 17.0),);
  }
}
