/*
总的容器应用, 采用tab布局控制
 */
import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';
import 'package:mine/pages/confession/confession_page.dart';
import 'package:mine/pages/home/home_page.dart';
import 'package:mine/pages/ours/ours_page.dart';
import 'package:mine/pages/photo/photo_page.dart';
import 'package:mine/pages/video/video_page.dart';
import 'package:mine/utils/logging_util.dart';

// 定义底部Tabbar图标
class _Item {
  String name;
  Icon activeIcon;
  Icon normalIcon;

  _Item({this.name, this.activeIcon, this.normalIcon});
}

class MainContainer extends StatefulWidget {
  MainContainer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainContainerState();
  }
}

// 页面底部使用tab切换
class _MainContainerState extends State<MainContainer> {
  var _logger = Logger('_MainContainerState');

  final HomePage homePage = HomePage();

  List<Widget> pages;

  final tabItems = [
    _Item(
        name: "图片集",
        activeIcon: Icon(Icons.photo, color: ColorConfig.defaultBlue, size: 30),
        normalIcon: Icon(
          Icons.photo,
          size: 30,
        )),
    _Item(
        name: "告白",
        activeIcon:
            Icon(Icons.markunread, color: ColorConfig.defaultBlue, size: 30),
        normalIcon: Icon(Icons.markunread, size: 30)),
    _Item(
        name: "主页",
        activeIcon: Icon(Icons.home, color: ColorConfig.defaultBlue, size: 30),
        normalIcon: Icon(Icons.home, size: 30)),
    _Item(
        name: "视频集",
        activeIcon:
            Icon(Icons.video_library, color: ColorConfig.defaultBlue, size: 30),
        normalIcon: Icon(Icons.video_library, size: 30)),
    _Item(
        name: "我们的",
        activeIcon: Icon(Icons.group, color: ColorConfig.defaultBlue, size: 30),
        normalIcon: Icon(Icons.group, size: 30)),
  ];

  List<BottomNavigationBarItem> bottomNavigationBars;

  int _activeIndex = 2;

  @override
  void initState() {
    super.initState();
    _logger.log('init tab menu ....');
    // 初始化
    if (pages == null) {
      pages = [
        PhotoPage(),
        ConfessionPage(),
        homePage,
        VideoPage(),
        OursPage()
      ];
    }
    if (null == bottomNavigationBars) {
      bottomNavigationBars = tabItems
          .map((tab) => BottomNavigationBarItem(
              icon: tab.normalIcon,
              title: Text(
                tab.name,
                style: TextStyle(fontSize: 10),
              ),
              activeIcon: tab.activeIcon))
          .toList();
    }
  }

  // 定义一个方法, 实现tab页的选择
  Widget _getTabPage(int index) {
    return Offstage(
      offstage: _activeIndex != index,
      child: TickerMode(
        enabled: _activeIndex == index,
        child: pages[index],
      ),
    );
  }

  // 初始化底部Tab bar
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomNavigationBars,
      onTap: (index) {
        setState(() {
          _activeIndex = index;
        });
      },
      // 图标大小
      iconSize: 24,
      currentIndex: _activeIndex,
      //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
      fixedColor: ColorConfig.defaultBlue,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  void didUpdateWidget(MainContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _logger.log('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    _logger.log('start building the main tabs....');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Stack(
        children: <Widget>[
          _getTabPage(0),
          _getTabPage(1),
          _getTabPage(2),
          _getTabPage(3),
          _getTabPage(4),
        ],
      ),
    );
  }
}
