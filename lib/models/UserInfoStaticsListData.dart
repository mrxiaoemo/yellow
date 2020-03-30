class UserInfoStaticsListData {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  int num;
  int type;

  UserInfoStaticsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = "",
    this.endColor = "",
    this.num = 0,
    this.type = 0,
  });

  static List<UserInfoStaticsListData> tabIconsList = [
    UserInfoStaticsListData(
      imagePath: 'assets/fitness_app/en.png',
      titleTxt: '开口次数',
      num: 32,
      type: 1,
      startColor: "#FA7D82",
      endColor: "#FFB295",
    ),
    UserInfoStaticsListData(
      imagePath: 'assets/fitness_app/math.png',
      titleTxt: '已学课程',
      num: 16,
      type: 2,
      startColor: "#738AE6",
      endColor: "#5C5EDD",
    ),
    UserInfoStaticsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: '已读绘本',
      num: 20,
      type: 3,
      startColor: "#FE95B6",
      endColor: "#FF5287",
    ),
  ];
}
