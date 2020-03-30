import 'package:aispeak/fintnessAppTheme.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/route/application.dart';
import 'package:aispeak/route/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final ProductInfoData data;

  const PictureView(
      {Key key, this.data, this.animationController, this.animation})
      : super(key: key);

  void navi(BuildContext context, id) {
    Application.router
        .navigateTo(context, Routes.pictureDetailPage + "?id=" + id);
  }

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
              child: InkWell(
                splashColor: Colors.transparent,
                  onTap: () => navi(context, data.id),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
//                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              color: FintnessAppTheme.background,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                ClipOval(
                                                  child: Image.network(
                                                    data.cover,
                                                    fit: BoxFit.cover,
                                                    width: 35,
                                                    height: 35,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      data.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      data.createTime,
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey
                                                              .withOpacity(1)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AspectRatio(
                                aspectRatio: 1,
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {
                                    //moveTo(context, data);
                                  },
                                  child: CachedNetworkImage(
                                    width: 100,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    imageUrl: data.cover,
                                    placeholder: (context, url) => SizedBox(
                                      width: 10.0,
                                      height: 10.0,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Color(0xffff0000),
                                        strokeWidth: 11,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )),
                            Container(
                              color: FintnessAppTheme.background,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${data.title}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: <Widget>[
//                                                  Icon(
//                                                    Icons.location_on,
//                                                    color: FintnessAppTheme
//                                                        .dark_grey
//                                                        .withOpacity(0.6),
//                                                    size: 15,
//                                                  ),
//                                                  Text(
//                                                    " ${data.view}米",
//                                                    style: TextStyle(
//                                                        fontSize: 14,
//                                                        color: FintnessAppTheme
//                                                            .dark_grey
//                                                            .withOpacity(0.6)),
//                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: FintnessAppTheme
                                                        .nearlyDarkBlue
                                                        .withOpacity(0.6),
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    " ${data.view}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: FintnessAppTheme
                                                            .nearlyDarkBlue
                                                            .withOpacity(0.6)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.favorite_border,
                                                    color: FintnessAppTheme
                                                        .nearlyDarkBlue
                                                        .withOpacity(0.6),
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    " ${data.view}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: FintnessAppTheme
                                                            .nearlyDarkBlue
                                                            .withOpacity(0.6)),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Icon(
                                                    Icons.comment,
                                                    color: FintnessAppTheme
                                                        .nearlyDarkBlue
                                                        .withOpacity(0.6),
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    " ${data.view}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: FintnessAppTheme
                                                            .nearlyDarkBlue
                                                            .withOpacity(0.6)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: FintnessAppTheme.nearlyDarkBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 25,
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/fitness_app/vip.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
