import 'package:aispeak/fintnessAppTheme.dart';
import 'package:aispeak/main.dart';
import 'package:aispeak/models/UserInfoStaticsListData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoStaticsListView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;

  const UserInfoStaticsListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  @override
  _UserInfoStaticsListViewState createState() =>
      _UserInfoStaticsListViewState();
}

class _UserInfoStaticsListViewState extends State<UserInfoStaticsListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<UserInfoStaticsListData> userInfoStaticsListData =
      UserInfoStaticsListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 81,
              color: FintnessAppTheme.white,
              width: double.infinity,
              child: ListView.builder(
                padding:
                    const EdgeInsets.only(top: 5, bottom: 0, right: 0, left: 0),
                itemCount: userInfoStaticsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var count = userInfoStaticsListData.length > 10
                      ? 10
                      : userInfoStaticsListData.length;
                  var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return UserInfoStaticsView(
                    userInfoStaticsListData: userInfoStaticsListData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserInfoStaticsView extends StatelessWidget {
  final UserInfoStaticsListData userInfoStaticsListData;
  final AnimationController animationController;
  final Animation animation;

  const UserInfoStaticsView(
      {Key key,
      this.userInfoStaticsListData,
      this.animationController,
      this.animation})
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
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: Container(
              color: FintnessAppTheme.white,
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, left: 1, right: 1, bottom: 1),
                    child: Container(
                      width: 112,
                      decoration: BoxDecoration(
//                        boxShadow: <BoxShadow>[
//                          BoxShadow(
//                              color: HexColor(userInfoStaticsListData.endColor)
//                                  .withOpacity(0.6),
//                              offset: Offset(1.1, 4.0),
//                              blurRadius: 8.0),
//                        ],
                        gradient: LinearGradient(
                          colors: [
                            HexColor(userInfoStaticsListData.startColor),
                            HexColor(userInfoStaticsListData.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(3.0),
                          bottomLeft: Radius.circular(3.0),
                          topLeft: Radius.circular(3.0),
                          topRight: Radius.circular(3.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 1, right: 1, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              userInfoStaticsListData.num.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: FintnessAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
//                                    Container(
//                                      child: CachedNetworkImage(
//                                        imageUrl:
//                                            userInfoStaticsListData.imagePath,
//                                      ),
//                                    ),
                                    Container(
                                      child: Text(
                                        userInfoStaticsListData.titleTxt
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          letterSpacing: 0.2,
                                          color: FintnessAppTheme.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
