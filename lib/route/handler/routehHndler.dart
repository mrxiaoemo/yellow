import 'dart:convert';

import 'package:aispeak/models/product_model.dart';
import 'package:aispeak/pages/Video/VideoScreen.dart';
import 'package:aispeak/pages/live/LiveDetailScreen.dart';
import 'package:aispeak/pages/picture/PictureDetailScreen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  print('index>details goodsID is ${id}');
  return VideoScreen(id: id);
});

Handler liveDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String productInfoData = params['productInfoData'].first;
  final json =jsonDecode(productInfoData);
  return LiveDetailScreen(productInfoData: ProductInfoData.fromJson(json));
});

Handler pictureDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  print('index>details goodsID is ${id}');
  return PictureDetailScreen(id: id);
});
