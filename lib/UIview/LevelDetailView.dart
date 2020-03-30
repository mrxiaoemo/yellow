import 'package:aispeak/fintnessAppTheme.dart';
import 'package:aispeak/models/LevelData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LevelDetailView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final VoidCallback callback;
  final LevelData data;

  const LevelDetailView(
      {Key key,
      this.data,
      this.animationController,
      this.animation,
      this.callback})
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
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: HexColor("#FA7D82").withOpacity(0.6),
                        offset: Offset(1.1, 4.0),
                        blurRadius: 8.0),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      HexColor("#FFB295"),
                      HexColor("#FA7D82"),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      //callback();

                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: Offset(4, 4),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: SizedBox(
                                    width: 114,
                                    height: 130,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(0),
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/fitness_app/imageplaceholder.png",
                                        image: data.cover,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  color: FintnessAppTheme.white,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, left: 4,right: 10, bottom: 16),
                                          child: Text(
                                            data.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: FintnessAppTheme.darkText,
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, left: 10, bottom: 16,right: 10),
                                        child: Text(
                                          data.subtitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            letterSpacing: 0.2,
                                            color: FintnessAppTheme.dark_grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            )),
                        Positioned(
                          left: 74,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(0),
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(0),
                            ),
                            child: Container(
                                width: 40,
                                height: 15,
                                decoration: new BoxDecoration(
                                  color: FintnessAppTheme.darkerBg,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 10,
                                      height: 10,
                                      child: Image.asset(
                                          "assets/fitness_app/play_count.png"),
                                    ),
                                    Text(
                                      data.viewCount == null
                                          ? "1410"
                                          : data.viewCount.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        letterSpacing: 0.2,
                                        color: FintnessAppTheme.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }

//  void moveTo(context, data) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => PictureDetailScreen(
//            data: data, key: key, animationController: animationController),
//      ),
//    );
//  }
}
