class ProductModel {
  String _code;
  ProductInfoData _data;

  ProductModel({String code, ProductInfoData data}) {
    this.code = code;
    this._data = data;
  }


  String get code => _code;

  set code(String value) {
    _code = value;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['datas'] != null
        ? new ProductInfoData.fromJson(json['datas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datas'] = this._code;
    if (this._data != null) {
      data['datas'] = this._data.toJson();
    }
    return data;
  }

  ProductInfoData get data => _data;

  set data(ProductInfoData value) {
    _data = value;
  }
}

class ProductInfoData {
  String _id,
      _title,
      _content,
      _url,
      _cover,
      _category,
      _type,
      _createTime;
  int _view, _support, _collect, _download;
  String _tag;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  ProductInfoData(
      {String id,
      String title,
      String tag,
      String content,
      String url,
      String cover,
      String category,
      int view,
      int support,
      int collect,
      int download,
      String type,
      String createTime}) {
    this._id = id;
    this._title = title;
    this._tag = tag;
    this._content = content;
    this._url = url;
    this._category=category;
    this._cover = cover;
    this._view = view;
    this._createTime= createTime;
    this._support = support;
    this._collect = collect;
    this._download = download;
    this._type = type;
  }

  ProductInfoData.fromJson(Map<String, dynamic> json) {

    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _url = json['url'];
    _cover = json['cover'];
    _view = json['view'];
    _support = json['support'];
    _collect = json['collect'];
    _download = json['download'];
    _category = json['category'];
    _tag = json['tag'];
    _type = json['type'];
    _createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['content'] = this._content;
    data['url'] = this._url;
    data['cover'] = this._cover;
    data['view'] = this._view;
    data['support'] = this._support;
    data['category'] = this._category;
    data['collect'] = this._collect;
    data['download'] = this._download;
    data['tag'] = this._tag;
    data['type'] = this._type;
    data['createTime'] = this._createTime;
    return data;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  get content => _content;

  set content(value) {
    _content = value;
  }

  get url => _url;

  set url(value) {
    _url = value;
  }

  get cover => _cover;

  set cover(value) {
    _cover = value;
  }

  get category => _category;

  set category(value) {
    _category = value;
  }

  get type => _type;

  set type(value) {
    _type = value;
  }

  get createTime => _createTime;

  set createTime(value) {
    _createTime = value;
  }

  int get view => _view;

  set view(int value) {
    _view = value;
  }

  get support => _support;

  set support(value) {
    _support = value;
  }

  get collect => _collect;

  set collect(value) {
    _collect = value;
  }

  get download => _download;

  set download(value) {
    _download = value;
  }

  String get tag => _tag;

  set tag(String value) {
    _tag = value;
  }
}
