class LevelTypeListData {
  String title;
  String type;
  bool isSelected = false;

  LevelTypeListData({
    this.title = '',
    this.type = '',
    this.isSelected = false,
  });

  static List<LevelTypeListData> tabIconsList = [
    LevelTypeListData(type: '0', title: '全部', isSelected: true),
    LevelTypeListData(type: '1', title: '英语', isSelected: false),
    LevelTypeListData(type: '2', title: '语文', isSelected: false),
    LevelTypeListData(type: '3', title: '数学', isSelected: false),
    LevelTypeListData(type: '4', title: '绘本', isSelected: false),
    LevelTypeListData(type: '5', title: "视频", isSelected: false),
    LevelTypeListData(type: '6', title: "亲子", isSelected: false),
    LevelTypeListData(type: '7', title: "儿歌", isSelected: false),
    LevelTypeListData(type: '8', title: "steam", isSelected: false)
  ];
}
