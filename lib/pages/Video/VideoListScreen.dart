import 'dart:async';

import 'package:aispeak/UIview/PictureView.dart';
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
class VideoListScreen extends StatefulWidget {
  final AnimationController animationController;

  const VideoListScreen({Key key, this.animationController}) : super(key: key);

  @override
  VideoListScreenState createState() {
    return VideoListScreenState();
  }
}

class VideoListScreenState extends State<VideoListScreen> {
  // 总数
  List<ProductInfoData> _hotListData = new List();
  int pageNo = 1;
  int pageSize = 20;
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  var scrollController = ScrollController();

  @override
  void initState() {
    loadHotList(pageSize, pageNo, "", "", "","create_time","desc");
    topBarAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('视频'),
        backgroundColor: Colors.orange,
      ),
      body: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          pageNo=1;
          loadHotList(pageSize, pageNo, "", "", "","create_time","desc");
        },
        onLoad: () async {
          pageNo++;
          loadHotList(pageSize, pageNo, "", "", "","create_time","desc");
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: widget.animationController,
                        curve: Interval((1 / _hotListData.length * index), 1.0,
                            curve: Curves.fastOutSlowIn)));
//                return PictureView(
//                    data: _hotListData[index],
//                    animationController: widget.animationController,
//                    animation: animation);
              return SampleListItem(data: _hotListData[index],);
              },
              childCount: _hotListData.length,
            ),
          ),
        ],
      ),
    );
  }

  loadHotList(int pageSize, int pageNo, String category, String free,String keyword,String orderBy,String sort) {
    ProductApi.fetchList("01", category, pageSize, pageNo, keyword,orderBy,sort)
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
}
