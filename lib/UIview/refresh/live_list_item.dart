import 'dart:convert';

import 'package:aispeak/appTheme.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/route/application.dart';
import 'package:aispeak/route/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 简单列表项
class LiveListItem extends StatelessWidget {
  final ProductInfoData data;

  /// 方向
  final Axis direction;

  /// 宽度
  final double width;

  const LiveListItem({
    Key key,
    this.direction = Axis.vertical,
    this.width = double.infinity,
    this.data,
  }) : super(key: key);

  void navi(BuildContext context, id) {
    Application.router.navigateTo(context, Routes.liveDetailPage + "?productInfoData=" + Uri.encodeComponent(jsonEncode(data)));
  }

  @override
  Widget build(BuildContext context) {
    double coverSize = 110;
    return InkWell(
        onTap: () => navi(context, data.id),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                        image: data.cover,
                        fit: BoxFit.fill,
                        placeholder: "assets/fitness_app/imageplaceholder.png"),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: coverSize / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color.fromARGB(100, 0, 0, 0)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ].where((item) => item != null).toList(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            SizedBox(
              height: 40,
              child: Text(
                this.data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ));
  }
}
