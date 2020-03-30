import 'package:aispeak/UIview/UserInfoStaticsListView.dart';
import 'package:aispeak/UIview/list_item.dart';
import 'package:aispeak/UIview/runningView.dart';
import 'package:aispeak/UIview/titleView.dart';
import 'package:aispeak/UIview/userInfo.dart';
import 'package:aispeak/UIview/vipAdView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../fintnessAppTheme.dart';

/// 个人中心页面
class UserProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const UserProfileScreen({Key key, this.animationController})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();

  @override
  void initState() {
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addItemData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
//            /getTopUserInfo(),
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getTopUserInfo() {
    return FutureBuilder(builder: (context, snapshot) {
      return Container(
        child: new InkWell(
            onTap: () {
              "a" == null ? debugPrint('登录') : debugPrint('用户信息');
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: new DecorationImage(
                          image: new NetworkImage(
                              "https://upload.jianshu.io/users/upload_avatars/16032460/1c74fa7b-7d77-47b4-b370-16b4686ff0aa?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp"),
                          fit: BoxFit.cover),
                      border: new Border.all(color: Colors.white, width: 2.0)),
                ),
                new Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: new Text(
                    '点击头像登录',
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )
              ],
            )),
      );
    });
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      builder: (context, snapshot) {
        return ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.only(
//            top: AppBar().preferredSize.height +
//                MediaQuery.of(context).padding.top +
//                24,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: listViews.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            widget.animationController.forward();
            return listViews[index];
          },
        );
      },
    );
  }

  void addItemData() {
    const int count = 6;
    listViews.add(UserInfoView(
        name: "小哥哥",
        backgroundUrl: "http://static.aispeak.com.cn/icon/day.jpg",
        avatar:
            "https://c-ssl.duitang.com/uploads/item/201704/10/20170410095843_SEvMy.thumb.1000_0.jpeg",
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
//    listViews.add(UserInfoStaticsListView(
//        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((2 / count) * 0, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController));
    listViews.add(addBlack());
//    listViews.add(ListItem(
//        icon: Container(
//          width: 30,
//          height: 30,
//          child: CachedNetworkImage(
//              imageUrl: "https://static.aispeak.com.cn/icon/order2.png"),
//        ),
//        title: "我的订单",
//        titleColor: FintnessAppTheme.darkText,
//        describe: 'my orders',
//        describeColor: FintnessAppTheme.darkText,
//        rightWidget: Container(
//          child: Icon(Icons.keyboard_arrow_right),
//        ),
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((2 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController));
//    listViews.add(addline());
//    listViews.add(ListItem(
////        icon: Container(
////          width: 30,
////          height: 30,
////          child: CachedNetworkImage(
////              imageUrl: "https://static.aispeak.com.cn/icon/lesson2.png"),
////        ),
////        title: "我的课程",
////        rightWidget: Container(
////          child: Icon(Icons.keyboard_arrow_right),
////        ),
////        titleColor: FintnessAppTheme.darkText,
////        describe: 'my lessons',
////        describeColor: FintnessAppTheme.darkText,
////        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
////            parent: widget.animationController,
////            curve:
////                Interval((3 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
////        animationController: widget.animationController));
////    listViews.add(addline());
//
//    listViews.add(
//      VipAdView(
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//            Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

    listViews.add(ListItem(
        icon: Container(
          width: 30,
          height: 30,
          child: CachedNetworkImage(
              imageUrl: "https://static.aispeak.com.cn/icon/collect.png"),
        ),
        title: "我的收藏",
        rightWidget: Container(
          child: Icon(Icons.keyboard_arrow_right),
        ),
        titleColor: FintnessAppTheme.darkText,
        describe: 'my Collection',
        describeColor: FintnessAppTheme.darkText,
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((4 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
    listViews.add(addline()); listViews.add(ListItem(
        icon: Container(
          width: 30,
          height: 30,
          child: CachedNetworkImage(
              imageUrl: "https://static.aispeak.com.cn/icon/chart.png"),
        ),
        title: "我的数据",
        rightWidget: Container(
          child: Icon(Icons.keyboard_arrow_right),
        ),
        titleColor: FintnessAppTheme.darkText,
        describe: 'my Collection',
        describeColor: FintnessAppTheme.darkText,
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((4 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
    listViews.add(addline());
    listViews.add(ListItem(
        icon: Container(
          width: 30,
          height: 30,
          child: CachedNetworkImage(
              imageUrl: "https://static.aispeak.com.cn/icon/info2.png"),
        ),
        title: "关于我们",
        rightWidget: Container(
          child: Icon(Icons.keyboard_arrow_right),
        ),
        titleColor: FintnessAppTheme.darkText,
        describe: 'about us',
        describeColor: FintnessAppTheme.darkText,
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((5 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
    listViews.add(addline());
    listViews.add(ListItem(
        icon: Container(
          width: 30,
          height: 30,
          child: CachedNetworkImage(
              imageUrl: "https://static.aispeak.com.cn/icon/service2.png"),
        ),
        title: "联系客服",
        rightWidget: Container(
          child: Icon(Icons.keyboard_arrow_right),
        ),
        titleColor: FintnessAppTheme.darkText,
        describe: 'contact us',
        describeColor: FintnessAppTheme.darkText,
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((5 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
    listViews.add(addline());
    listViews.add(ListItem(
        icon: Container(
          width: 30,
          height: 30,
          child: CachedNetworkImage(
              imageUrl: "https://static.aispeak.com.cn/icon/setting2.png"),
        ),
        title: "设置",
        rightWidget: Container(
          child: Icon(Icons.keyboard_arrow_right),
        ),
        titleColor: FintnessAppTheme.darkText,
        describe: 'setting',
        describeColor: FintnessAppTheme.darkText,
        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((6 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController));
  }

  Widget addline() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 1),
      child: Container(
        height: 0,
        decoration: BoxDecoration(
          color: FintnessAppTheme.background,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }
  Widget addBlack() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Container(
        height: 15,
        decoration: BoxDecoration(
          color: FintnessAppTheme.white,
        ),
      ),
    );
  }
}
