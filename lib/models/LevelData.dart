class LevelData {
  String _id;
  String _createdTime;
  String _title;
  String _subtitle;
  String _content;
  String _cover;
  String _free;
  double _originalPrice;
  double _price;
  int _rate;
  int _assistNumber;
  String _express;
  String _recommend;
  String _type;
  int _viewCount;

  LevelData( {
    String id,
    String createdTime,
    String title,
    String subtitle,
    String content,
    String cover,
    String free,
    double originalPrice,
    double price,
    int rate,
    int assistNumber,
    String express,
    String recommend,
    String type,
    int viewCount
  })

  {
    this._id = id;
    this._createdTime = createdTime;
    this._title = title;
    this._subtitle = subtitle;
    this._content = content;
    this._cover = cover;
    this._free = free;
    this._originalPrice = originalPrice;
    this._price = price;
    this._rate = rate;
    this._assistNumber = assistNumber;
    this._express = express;
    this._recommend = recommend;
    this._type = type;
    this._viewCount = viewCount;
  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  LevelData.fromJson(
      Map<String, dynamic> json)

  {
    _id = json['id'];
    _createdTime = json['createdTime'];
    _title = json['title'];
    _subtitle = json['subtitle'];
    _content = json['content'];
    _cover = json['cover'];
    _free = json['free'];
    _originalPrice = json['originalPrice'];
    _price = json['price'];
    _rate = json['rate'];
    _assistNumber = json[' assistNumber'];
    _express = json['express'];
    _recommend = json['recommend'];
    _type = json['type'];
    _viewCount = json[' viewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['createdTime'] = this._createdTime;
    data['title'] = this._title;
    data['subtitle'] = this._subtitle;
    data['content'] = this._content;
    data['cover'] = this._cover;
    data['free'] = this._free;
    data['originalPrice'] = this._originalPrice;
    data['price'] = this._price;
    data['rate'] = this._rate;
    data['assistNumber'] = this._assistNumber;
    data['express'] = this._express;
    data['recommend'] = this._recommend;
    data['type'] = this._type;
    data['viewCount'] = this._viewCount;
    return data;
  }

  String get createdTime => _createdTime;

  set createdTime(String value) {
    _createdTime = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get subtitle => _subtitle;

  set subtitle(String value) {
    _subtitle = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get cover => _cover;

  set cover(String value) {
    _cover = value;
  }

  String get free => _free;

  set free(String value) {
    _free = value;
  }

  double get originalPrice => _originalPrice;

  set originalPrice(double value) {
    _originalPrice = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get rate => _rate;

  set rate(int value) {
    _rate = value;
  }

  int get assistNumber => _assistNumber;

  set assistNumber(int value) {
    _assistNumber = value;
  }

  String get express => _express;

  set express(String value) {
    _express = value;
  }

  String get recommend => _recommend;

  set recommend(String value) {
    _recommend = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get viewCount => _viewCount;

  set viewCount(int value) {
    _viewCount = value;
  }
}
