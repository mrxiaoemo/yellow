import 'package:aispeak/fintnessAppTheme.dart';
import 'package:aispeak/main.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/route/application.dart';
import 'package:aispeak/route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLevelListView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation mainScreenAnimation;
  final List<ProductInfoData> listData;

  const HomeLevelListView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      this.listData})
      : super(key: key);

  @override
  _HomeLevelListViewState createState() => _HomeLevelListViewState();
}

class _HomeLevelListViewState extends State<HomeLevelListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

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
                height: 206,
                width: double.infinity,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, right: 16, left: 16),
                  itemCount: widget.listData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var count = widget.listData.length > 10
                        ? 10
                        : widget.listData.length;
                    var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn)));
                    animationController.forward();

                    return LevelView(
                      data: widget.listData[index],
                      animation: animation,
                      animationController: animationController,
                    );
                  },
                )),
          ),
        );
      },
    );
  }
}

class LevelView extends StatelessWidget {
  final ProductInfoData data;
  final AnimationController animationController;
  final Animation animation;

  const LevelView(
      {Key key, this.data, this.animationController, this.animation})
      : super(key: key);

  void navi(BuildContext context,id) {
    Application.router.navigateTo(context,Routes.detailsPage+"?id="+id);
  }
  void naviToImage(BuildContext context,id) {
    Application.router.navigateTo(context,Routes.pictureDetailPage+"?id="+id);
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: InkWell(
            onTap:()=>data.type=='01'?navi(context,data.id):naviToImage(context,data.id),
            child:new Transform(
            transform: new Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: HexColor("#738AE6").withOpacity(0.6),
                                  offset: Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                HexColor("#FA7D82"),
                                HexColor("#FFB295"),
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 124, left: 2, right: 2, bottom: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          height: 40,
                                          child: Text(
                                            data.title,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                  Positioned(
                    top: 32,
                    left: 8,
                    child: SizedBox(
                      width: 114,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/fitness_app/imageplaceholder.png",
                          image: data.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 137,
                    left: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(5.0),
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
                                data.view.toString() + "",
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
                  ),
                  data.type=="01"?
                  Positioned(
                    top: 117,
                    right: 18,
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                          "assets/fitness_app/icon_video_player_control_play.png"),
                    ),
                  ):new Container()
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
