class LevelListData {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  int count;
  int type;

  LevelListData(
      {this.imagePath = '',
      this.titleTxt = '',
      this.startColor = "",
      this.endColor = "",
      this.count = 0,
      this.type = 1});

  static List<LevelListData> tabIconsList = [
    LevelListData(
      imagePath: 'https://static.aispeak.com.cn/image/20200316174018.png',
      titleTxt: 'level 1',
      count: 312,
      type: 1,
      startColor: "#FA7D82",
      endColor: "#FFB295",
    ),
    LevelListData(
      imagePath:
          'https://sitemaker-aichat.oss-cn-hangzhou.aliyuncs.com/image/20200306195049.png',
      titleTxt: '百万播放的绘本视频',
      count: 1641,
      type: 2,
      startColor: "#738AE6",
      endColor: "#5C5EDD",
    ),
    LevelListData(
      imagePath: 'https://static.aispeak.com.cn/image/20200312111022.jpg',
      titleTxt: 'Eric Carle 系列绘本',
      count: 1126,
      type: 1,
      startColor: "#738AE6",
      endColor: "#FF5287",
    ),
    LevelListData(
      imagePath:
          'https://sitemaker-aichat.oss-cn-hangzhou.aliyuncs.com/image/20200306234646.png',
      titleTxt: '海尼曼自然拼读系列',
      count: 1126,
      type:2,
      startColor: "#738AE6",
      endColor: "#1E1466",
    )
  ];
}
