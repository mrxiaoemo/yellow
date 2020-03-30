import 'package:flutter/material.dart';

class TabIconData {
  String imagePath;
  String selctedImagePath;
  String title;
  bool isSelected;
  int index;
  AnimationController animationController;

  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selctedImagePath = "",
    this.isSelected = false,
    this.title = "",
    this.animationController
  });

  static List<TabIconData> tabIconsList = [
    TabIconData(
      imagePath: 'assets/fitness_app/home.png',
      selctedImagePath: 'assets/fitness_app/home_s.png',
      title:"首页",
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/discovery.png',
      selctedImagePath: 'assets/fitness_app/discovery_s.png',
      index: 1,
      title:"视频",
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/picture.png',
      selctedImagePath: 'assets/fitness_app/picture_s.png',
      index: 2,
      title:"图片",
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/live.png',
      selctedImagePath: 'assets/fitness_app/live_s.png',
      index: 3,
      title:"直播",
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/me.png',
      selctedImagePath: 'assets/fitness_app/me_s.png',
      index:4,
      title:"我的",
      isSelected: false,
      animationController: null,
    )
  ];
}
