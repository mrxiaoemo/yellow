import 'dart:async';

import 'package:aispeak/UIview/PictureView.dart';
import 'package:aispeak/UIview/refresh/live_list_item.dart';
import 'package:aispeak/UIview/refresh/picture_list_item.dart';
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
class PictureScreen extends StatefulWidget {
  final AnimationController animationController;

  const PictureScreen({Key key, this.animationController}) : super(key: key);

  @override
  PictureScreenState createState() {
    return PictureScreenState();
  }
}

class PictureScreenState extends State<PictureScreen> {
  // 总数
  List<ProductInfoData> _hotListData = new List();
  int pageNo = 1;
  int pageSize = 20;
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  var scrollController = ScrollController();

  @override
  void initState() {
    loadHotList(pageSize, pageNo, "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('美图'),
        backgroundColor: Colors.orange,
      ),
      body: EasyRefresh.custom(
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
                return PictureListItem(data: _hotListData[index]);
              },
              childCount: _hotListData.length,
            ),
          ),
        ],
      ),
    );
  }

  loadHotList(int pageSize, int pageNo, String category, String free, keyword) {
    ProductApi.fetchList("02", category, pageSize, pageNo, keyword,"","")
        .then((value) {
      setState(() {
        if (value.code == '200' &&
            value.data != null &&
            value.data.length > 0) {
          _hotListData += value.data;
        }
      });
    });
  }
}
