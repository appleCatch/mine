/*
首页, 主页
 */
import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';
import 'package:mine/widgets/search_text_widget.dart';
import 'package:mine/widgets/extended_widgets.dart';
import 'package:mine/routers.dart';
import 'package:mine/utils/logging_util.dart';
import 'package:mine/bean/subject_bean_page.dart';
import 'package:mine/config/colors.dart';
import 'package:mine/commons/constants.dart';
import 'package:mine/widgets/radius_img.dart';
import 'package:mine/widgets/video_widget.dart';

var _tabs = ['动态', "推荐"];


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _tabs.length,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: BottomTextSliverAppBar(
                  pinned: true,
                  expandedHeight: 120.0,
                  primary: true,
                  titleSpacing: 0.0,
                  backgroundColor: ColorConfig.defaultWhite,
                  bottomTextString: _tabs,
                  bottom: TabBar(
                    tabs: _tabs.map((name) => Container(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(name),
                    )).toList(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      color: ColorConfig.defaultColor,
                      alignment: Alignment(0.0, 0.0),
                      child: SearchTextFieldWidget(
                        hintText: '心中那一抹温存',
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
                        onTab: (){
                          Router.pushWithParams(context, Router.searchPage, '难忘的瞬间');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: _tabs
                  .map((tabName) => _SliverContainer(
                        name: tabName,
                      ))
                  .toList())),
    );
  }
}

class _SliverContainer extends StatefulWidget {
  final String name;

  _SliverContainer({Key key, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SliverContainerState();
  }
}

class _SliverContainerState extends State<_SliverContainer> {
  var _logger = Logger("_SliverContainerState");
  List<Subject> list;
  @override
  void initState(){
    super.initState();
    _logger.log('init home page tab container ${widget.name}.....');
    // 填充数据
    if(list == null || list.isEmpty) {
      _requestData();
    }
  }

  void _requestData() async {
    //todo 待实现
  }

  @override
  Widget build(BuildContext context) {
    return _getContentSliver(context, list);
  }

  Widget _getContentSliver(BuildContext context, List<Subject> list) {
    if(widget.name == _tabs[0]) {
      return _loginContainer(context);
    }
    _logger.log('build content sliver');
    if (list == null || list.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('暂无数据', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: IconButton(
                icon: Icon(Icons.add_a_photo, color: ColorConfig.defaultBlue, size: 50,),
                onPressed: (){
                  Router.pushNoParams(context, Router.uploadFile);
                }
            ),
          ),
        ],
      );
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return CustomScrollView(
          key: PageStorageKey(widget.name),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _getCommonItem(list, index);
                },
                childCount: list.length
              ),
            ),
          ],
        );
      }),
    );
  }


  double singleLineImgHeight = 180.0;
  double contentVideoHeight = 350.0;

  _getCommonItem(List<Subject> list, int index) {
    Subject item = list[index];
    bool showVideo = index == 1 || index == 3;
    return Container(
      height: showVideo ? contentVideoHeight : singleLineImgHeight,
      color: ColorConfig.defaultWhite,
      margin: EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(
          left: Constant.MARGIN_LEFT,
          right: Constant.MARGIN_RIGHT,
          top: Constant.MARGIN_RIGHT,
          bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(item.casts[0].avatars.medium),
                backgroundColor: ColorConfig.defaultWhite,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(item.title),
              ),
              Expanded(
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  alignment: Alignment.centerRight,
                ),
              )
            ],
          ),

          Expanded(
            child: Container(
              child: showVideo ? getContentVideo(index) : getItemCenterImg(item),
          )),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG +
                      'ic_notification_tv_calendar_comments.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_status_detail_reshare_icon.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  getItemCenterImg(Subject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: RadiusImg.get(item.images.large, null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
              )),
        ),
        Expanded(
          child: RadiusImg.get(item.casts[1].avatars.medium, null, radius: 0.0),
        ),
        Expanded(
          child: RadiusImg.get(item.casts[2].avatars.medium, null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)))),
        )
      ],
    );
  }

  getContentVideo(int index) {
    if(!mounted){
      return Container();
    }
    return VideoWidget(
      index == 1 ? Constant.URL_MP4_DEMO_0 :  Constant.URL_MP4_DEMO_1,
      showProgressBar: false,
    );
  }


  ///动态TAB
  _loginContainer(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Constant.ASSETS_IMG + 'ic_new_empty_view_default.png',
            width: 120.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
            child: Text(
              '登录后查看关注人动态',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          GestureDetector(
            child: Container(
              child: Text(
                '去登录',
                style: TextStyle(fontSize: 16.0, color: ColorConfig.defaultBlue),
              ),
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorConfig.defaultBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            ),
            onTap: () {
              Router.pushWithParams(context, Router.searchPage, '搜索笨啦灯');
            },
          )
        ],
      ),
    );
  }
}
