import 'package:aispeak/UIview/bodyMeasurement.dart';
import 'package:aispeak/UIview/glassView.dart';
import 'package:aispeak/UIview/mediterranesnDietView.dart';
import 'package:aispeak/UIview/refresh/sample_list_item.dart';
import 'package:aispeak/UIview/titleView.dart';
import 'package:aispeak/api/BannerApi.dart';
import 'package:aispeak/api/ProductApi.dart';
import 'package:aispeak/fintnessAppTheme.dart';
import 'package:aispeak/models/BannerData.dart';
import 'package:aispeak/models/LevelData.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/pages/Home/waterView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aispeak/UIview/runningView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:aispeak/UIview/PictureView.dart';
import 'package:aispeak/UIview/refresh/src/header/header.dart';

import 'homeLevelListView.dart';
import 'mealsListView.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomeScreen({Key key, this.animationController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  MethodChannel _channel;
  int viewId = 0;
  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;
  List<ProductInfoData> _hotListData = new List();
  List<ProductInfoData> _newListData = new List();
  List<ProductInfoData> _hotPictureListData = new List();
  List<ProductInfoData> _newPictureListData = new List();

  int pageNo = 1;
  int pageSize = 6;
  int _count = 20;
  List<BannerData> _listBanner = new List();

  @override
  void initState() {
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    getBanner();

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

  getBanner() {
    BannerApi.fetchList().then((value) {
      setState(() {
        addAllListData();
        _listBanner = value.data;
        if (_listBanner == null) {
          return;
        }
        listViews.add(Container(
          height: 150,
          child: Swiper(
              itemWidth: 350,
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(imageUrl: _listBanner[index].image);
              },
              viewportFraction: 0.8,
              scale: 0.9,
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
                  new CustomLayoutOption(startIndex: -1, stateCount: 3)
                      .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
                new Offset(-370.0, -40.0),
                new Offset(0.0, 0.0),
                new Offset(370.0, -40.0)
              ]),
              itemCount: _listBanner.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeSize: 4,
                size: 3,
                activeColor: Colors.orange,
              )),
              autoplay: true,
              onTap: (int index) {
                //todo
              }),
        ));
      });
    });
  }

  loadHotList(int pageSize, int pageNo, String category, String free,keyword) {
    ProductApi.fetchList("01", category, pageSize, pageNo, keyword,"view","DESC")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _hotListData = value.data;
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
          listViews.add(
            TitleView(
              titleTxt: '热门视频',
              animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                  Interval((1 / 2) * 2, 1.0, curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
            ),
          );
          listViews.add(
            HomeLevelListView(
              mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 2) * 3, 1.0,
                          curve: Curves.fastOutSlowIn))),
              mainScreenAnimationController: widget.animationController,
                listData:_hotListData
            ),
          );
        }
      });
    });
  }

  loadNewList(int pageSize, int pageNo, String category, String free,keyword) {
    ProductApi.fetchList("01", category, pageSize, pageNo, keyword,"create_time","DESC")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _newListData = value.data;
          for (var i = 0; i < _newListData.length; i++) {
            var count = _newListData.length;
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve:
                    Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
          }
          listViews.add(
            TitleView(
              titleTxt: '最新视频',
              animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                  Interval((1 / 2) * 2, 1.0, curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
            ),
          );
          listViews.add(
            HomeLevelListView(
              mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 2) * 3, 1.0,
                          curve: Curves.fastOutSlowIn))),
              mainScreenAnimationController: widget.animationController,
                listData:_newListData
            ),
          );
        }
      });
    });
  }

  loadHotPictureList(int pageSize, int pageNo, String category, String free,keyword) {
    ProductApi.fetchList("02", category, pageSize, pageNo, keyword,"view","DESC")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _hotPictureListData = value.data;
          for (var i = 0; i < _hotPictureListData.length; i++) {
            var count = _hotPictureListData.length;
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve:
                    Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
          }
          listViews.add(
            TitleView(
              titleTxt: '热门美图',
              animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                  Interval((1 / 2) * 2, 1.0, curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
            ),
          );
          listViews.add(
            HomeLevelListView(
              mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 2) * 3, 1.0,
                          curve: Curves.fastOutSlowIn))),
              mainScreenAnimationController: widget.animationController,
                listData:_hotPictureListData
            ),
          );
        }
      });
    });
  }

  loadNewPictureList(int pageSize, int pageNo, String category, String free,keyword) {
    ProductApi.fetchList("02", category, pageSize, pageNo, keyword,"create_time","DESC")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _newPictureListData = value.data;
          for (var i = 0; i < _newPictureListData.length; i++) {
            var count = _newPictureListData.length;
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve:
                    Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
          }
          listViews.add(
            TitleView(
              titleTxt: '最新美图',
              animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: widget.animationController,
                  curve:
                  Interval((1 / 2) * 2, 1.0, curve: Curves.fastOutSlowIn))),
              animationController: widget.animationController,
            ),
          );
          listViews.add(
            HomeLevelListView(
              mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: widget.animationController,
                      curve: Interval((1 / 2) * 3, 1.0,
                          curve: Curves.fastOutSlowIn))),
              mainScreenAnimationController: widget.animationController,
                listData:_newPictureListData
            ),
          );
        }
      });
    });
  }

  void addAllListData() {
    loadNewList(pageSize, pageNo, "", "", "");
    loadHotList(pageSize, pageNo, "", "", "");
    loadHotPictureList(pageSize, pageNo, "", "", "");
    loadNewPictureList(pageSize, pageNo, "", "", "");
 //  var count = 10;

//    listViews.add(
//      TitleView(
//        titleTxt: '上次学习',
//        subTxt: '详情',
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//    listViews.add(
//      MediterranesnDietView(
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//    listViews.add(
//      RunningView(
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//    listViews.add(Container(
//      height: 200,
//      child: AndroidView(
//        //设置标识
//        viewType: "com.flutter_to_native_test_textview",
//        creationParams: {
//          "content": "flutter 传入的文本内容",
//        },
//        //参数的编码方式
//        creationParamsCodec: const StandardMessageCodec(),
//        //view创建完成时的回调
//        onPlatformViewCreated: (id) {
//          viewId = id;
//        },
//      ),
//    ));
//    listViews.add(Container(
//        child: MaterialButton(
//      color: Colors.blue,
//      textColor: Colors.white,
//      child: new Text('开始'),
//      onPressed: () {
//        clickUpdate(1);
//      },
//    )));
//    listViews.add(Container(
//        child: MaterialButton(
//      color: Colors.blue,
//      textColor: Colors.white,
//      child: new Text('停止'),
//      onPressed: () {
//        clickUpdate(0);
//      },
//    )));
//    listViews.add(Container(
//        child: MaterialButton(
//      color: Colors.blue,
//      textColor: Colors.white,
//      child: new Text('申请权限'),
//      onPressed: () {
//        requestPermission();
//      },
//    )));

//    listViews.add(
//      TitleView(
//        titleTxt: '热门课程',
//        subTxt: 'more',
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//
//    listViews.add(
//      MealsListView(
//        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 3, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );
//
//    listViews.add(
//      TitleView(
//        titleTxt: '公开课',
//        subTxt: 'more',
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

//    listViews.add(
//      BodyMeasurementView(
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

//
//    listViews.add(
//      TitleView(
//        titleTxt: '最热',
//        subTxt: 'more',
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//    listViews.add(
//      HomeLevelListView(
//        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 3, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );

//    listViews.add(
//      TitleView(
//        titleTxt: 'Water',
//        subTxt: 'Aqua SmartBottle',
//        animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );

//    listViews.add(
//      WaterView(
//        mainScreenAnimation: Tween(begin: 0.0, end: 1.0).animate(
//            CurvedAnimation(
//                parent: widget.animationController,
//                curve: Interval((1 / count) * 7, 1.0,
//                    curve: Curves.fastOutSlowIn))),
//        mainScreenAnimationController: widget.animationController,
//      ),
//    );
//    listViews.add(
//      GlassView(
//          animation: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//              parent: widget.animationController,
//              curve:
//                  Interval((1 / count) * 8, 1.0, curve: Curves.fastOutSlowIn))),
//          animationController: widget.animationController),
//    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
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
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
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
                        height: MediaQuery.of(context).padding.top,
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
