import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'handler/routehHndler.dart';

class Routes {
  //配置类
  static String root = '/'; //根目录
  static String detailsPage = '/VideoScreen'; //详情页面
  static String liveDetailPage = '/LiveDetailScreen'; //详情页面
  static String pictureDetailPage = '/PictureDetailScreen'; //详情页面
  //静态方法
  static void configureRoutes(Router router) {
    //路由配置
    //找不到路由
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        }
    );
    //整体配置
    router.define(detailsPage, handler: detailHandler);
    router.define(liveDetailPage, handler: liveDetailHandler);
    router.define(pictureDetailPage, handler: pictureDetailHandler);
  }
}