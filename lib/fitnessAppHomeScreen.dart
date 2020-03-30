import 'package:aispeak/models/tabIconData.dart';
import 'package:aispeak/pages/Home/HomeScreen.dart';
import 'package:aispeak/pages/Video/VideoListScreen.dart';
import 'package:aispeak/pages/live/LiveScreen.dart';
import 'package:aispeak/pages/picture/PictureScreen.dart';
import 'package:aispeak/pages/user/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import 'bottomNavigationView/bottomBarView.dart';
import 'fintnessAppTheme.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FintnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    tabBody = HomeScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (index) {
            if (index == 0) {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  tabBody =
                      HomeScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  tabBody = VideoListScreen(
                      animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  tabBody = PictureScreen(
                      animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  tabBody =
                      LiveScreen(animationController: animationController);
                });
              });
            }else if (index == 4) {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  tabBody =
                      UserProfileScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
