class MealsListData {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = "",
    this.endColor = "",
    this.meals,
    this.kacl = 0,
  });

  static List<MealsListData> tabIconsList = [
    MealsListData(
      imagePath: 'assets/fitness_app/en.png',
      titleTxt: '英语',
      kacl: 32,
      meals: ["系统英语课，从幼儿园到小学"],
      startColor: "#FA7D82",
      endColor: "#FFB295",
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/math.png',
      titleTxt: '数学',
      kacl: 16,
      meals: ["Salmon,", "Mixed veggies,", "Avocado"],
      startColor: "#738AE6",
      endColor: "#5C5EDD",
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Snack',
      kacl: 0,
      meals: ["Recommend:", "800 kcal"],
      startColor: "#FE95B6",
      endColor: "#FF5287",
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      kacl: 0,
      meals: ["Recommend:", "703 kcal"],
      startColor: "#6F72CA",
      endColor: "#1E1466",
    ),
  ];
}
