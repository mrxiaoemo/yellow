import 'dart:async';

import 'package:aispeak/UIview/PictureView.dart';
import 'package:aispeak/UIview/refresh/live_list_item.dart';
import 'package:aispeak/UIview/refresh/sample_list_item.dart';
import 'package:aispeak/api/ProductApi.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../fintnessAppTheme.dart';

/// 质感设计样式
class LiveScreen extends StatefulWidget {
  final AnimationController animationController;

  const LiveScreen({Key key, this.animationController}) : super(key: key);

  @override
  LiveScreenState createState() {
    return LiveScreenState();
  }
}

class LiveScreenState extends State<LiveScreen> {
  // 总数
  List<ProductInfoData> _hotListData = new List();
  int pageNo = 1;
  int pageSize = 20;
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  var scrollController = ScrollController();

  @override
  void initState() {
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    loadHotList(pageSize, pageNo, "", "", "");

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
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
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .padding
                  .bottom,
            )
          ],
        ),
      ),
    );
  }

  getMainListViewUI() {
    return Scaffold(body: EasyRefresh.custom(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        pageNo=1;
        loadHotList(pageSize, pageNo, "", "", "");
      },
      onLoad: () async {
        pageNo++;
        loadHotList(pageSize, pageNo, "", "", "");
      },
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.6),
          delegate: SliverChildBuilderDelegate((context, index) {
            return LiveListItem(data: _hotListData[index],);
          },
            childCount: _hotListData.length,
          ),
        ),
      ],
    ),
    );
  }

  loadHotList(int pageSize, int pageNo, String category, String free, keyword) {
    ProductApi.fetchList(
        "04",
        category,
        pageSize,
        pageNo,
        keyword,
        "",
        "")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _hotListData += value.data;
          for (var i = 0; i < _hotListData.length; i++) {
            var count = _hotListData.length;
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve:
                Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
          }
        }
      });
    });
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FintnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FintnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .padding
                            .top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: ClipOval(
                                        child: FadeInImage.memoryNetwork(
                                          width: 35 - 6 * topBarOpacity,
                                          height: 35 - 6 * topBarOpacity,
                                          placeholder: kTransparentImage,
                                          image:
                                          'https://c-ssl.duitang.com/uploads/item/201704/10/20170410095843_SEvMy.thumb.1000_0.jpeg',
                                        ),
                                      )),
                                  Container(
                                    width: 80,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            "视频",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                              8 + 6 - 4 * topBarOpacity,
                                              letterSpacing: 0.7,
                                              color:
                                              FintnessAppTheme.darkerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.search,
                                    color: FintnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
