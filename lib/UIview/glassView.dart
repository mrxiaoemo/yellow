import 'package:aispeak/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../fintnessAppTheme.dart';

class GlassView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const GlassView({Key key, this.animationController, this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 0, bottom: 24),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor("#D7E0F9"),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                            // boxShadow: <BoxShadow>[
                            //   BoxShadow(
                            //       color: FintnessAppTheme.grey.withOpacity(0.2),
                            //       offset: Offset(1.1, 1.1),
                            //       blurRadius: 10.0),
                            // ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 68, bottom: 12, right: 16, top: 12),
                                child: Text(
                                  '日照香炉生紫烟，遥看瀑布挂前川。飞流直下三千尺，疑是银河落九天。\n -- 李白《望庐山瀑布》',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FintnessAppTheme.nearlyDarkBlue
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -12,
                        left: 0,
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: CachedNetworkImage(imageUrl: "https://static.aispeak.com.cn/icon/libai.png",),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
