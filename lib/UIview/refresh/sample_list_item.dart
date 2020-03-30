import 'package:aispeak/appTheme.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/route/application.dart';
import 'package:aispeak/route/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 简单列表项
class SampleListItem extends StatelessWidget {
  final ProductInfoData data;

  /// 方向
  final Axis direction;

  /// 宽度
  final double width;

  const SampleListItem({
    Key key,
    this.direction = Axis.vertical,
    this.width = double.infinity,
    this.data,
  }) : super(key: key);

  void navi(BuildContext context, id) {
    Application.router.navigateTo(context, Routes.detailsPage + "?id=" + id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: InkWell(
        onTap: () => navi(context, data.id),
        child: Row(
          children: <Widget>[
            Container(
              height: 100.0,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                    color: Colors.grey[200],
                    child: FadeInImage.assetNetwork(
                      image: data.cover,
                      placeholder: "assets/fitness_app/imageplaceholder.png",
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 210.0,
                                  height: 20.0,
                                  child: Text(
                                    data.title,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            color: Colors.grey[200],
                            child: Text(
                              "#" + data.tag,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppTheme.dark_grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            height: 10.0,
                          ),
                          Container(
                            height: 20.0,
                            width: 150.0,
                            child: Text(
                              data.createTime,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: AppTheme.dark_grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
//            Positioned(
//              left: 0,
//              right: 0,
//              bottom: 0,
//              child: Padding(
//                padding: EdgeInsets.all(5),
//                child: Row(
//                  children: <Widget>[
//                    Icon(
//                      Icons.play_arrow,
//                      color: Colors.white,
//                      size: 13,
//                    ),
//                    Padding(padding: EdgeInsets.only(left: 5)),
//                    Text(
//                      Helper.numFormat(this.data.view),
//                      style: TextStyle(
//                        fontSize: 14,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
          ],
        ),
      )),
    );
  }

}
class Helper {
  static String numFormat(int num) {
    if (num / 10000 < 1) {
      return 'num';
    } else if (num / 100000000 < 1) {
      return '${num ~/ 10000}万';
    } else {
      return '${num ~/ 100000000}亿';
    }
  }
}
