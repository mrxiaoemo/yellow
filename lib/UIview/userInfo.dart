import 'package:aispeak/fintnessAppTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 列表项
class UserInfoView extends StatefulWidget {
  // 点击事件
  final VoidCallback onPressed;

  // 标题
  final String name;
  // 标题
  final String avatar;
  // 标题
  final String backgroundUrl;

  final AnimationController animationController;
  final Animation animation;

  // 构造函数
  UserInfoView({
    Key key,
    this.onPressed,
    this.name,
    this.avatar,
    this.backgroundUrl,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: widget.animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation.value), 0.0),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 54,
                      bottom: 62,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new NetworkImage(widget.backgroundUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new InkWell(
                        onTap: () {
                          "a" == null ? debugPrint('登录') : debugPrint('用户信息');
                        },
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  image: new DecorationImage(
                                      image: new NetworkImage(widget.avatar),
                                      fit: BoxFit.cover),
                                  border: new Border.all(
                                      color: Colors.white, width: 2.0)),
                            ),
                            new Container(
                              margin: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: new Text(
                                widget.name==null?'点击头像登录':widget.name,
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 13.0),
                              ),
                            ),
//                            new Container(
//                              child: Image.asset("assets/fitness_app/wave.gif",),
//                            )
                          ],
                        )),
                  )));
        });
  }
}

/// 空图标
class EmptyIcon extends Icon {
  const EmptyIcon() : super(Icons.hourglass_empty);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
