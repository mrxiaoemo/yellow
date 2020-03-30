class ProductListModel {
  String _code;
  List<ProductInfoData> _data;

  ProductListModel({String code, List<ProductInfoData> data}) {
    this.code = code;
    this._data = data;
  }

  String get code => _code;

  set code(String code) => code = _code;

  List<ProductInfoData> get data => _data;

  set data(List<ProductInfoData> data) => _data = data;

  ProductListModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['datas'] != null) {
      _data = new List<ProductInfoData>();
      json['datas'].forEach((v) {
        _data.add(new ProductInfoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._data != null) {
      data['datas'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInfoData {
  String _id, _title, _content, _url, _cover, _category, _type, _createTime;
  int _view, _support, _collect, _download;
  String _tag;

  get content => _content;

  set content(value) {
    _content = value;
  }

  String get id => _id;

  set id(String id) => _id = id;

  String get title => _title;

  set title(String id) => _title = title;

  String get cover => _cover;

  set cover(String cover) => _cover = cover;

  String get url => _url;

  set url(String url) => _url = url;

  String get createTime => _createTime;

  set createTime(String url) => _createTime = url;

  int get view => _view;

  set view(int view) => _view = view;

  int get support => _support;

  set support(int support) => _support = support;

  int get download => _download;

  set download(int download) => _download = download;

  ProductInfoData(
      {String id,
      String title,
      String tag,
      String content,
      String url,
      String cover,
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
    this._cover = cover;
    this._view = view;
    this._support = support;
    this._collect = collect;
    this._download = download;
    this._type = type;
    this._createTime = createTime;
  }

  ProductInfoData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _url = json['url'];
    _cover = json['cover'].trim();
    _view = json['view'];
    _support = json['support'];
    _collect = json['collect'];
    _download = json['download'];
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
    data['collect'] = this._collect;
    data['download'] = this._download;
    data['tag'] = this._tag;
    data['type'] = this._type;
    data['createTime'] = this._createTime;
    return data;
  }

  get category => _category;

  set category(value) {
    _category = value;
  }

  get type => _type;

  set type(value) {
    _type = value;
  }

  get collect => _collect;

  set collect(value) {
    _collect = value;
  }

  String get tag => _tag;

  set tag(String value) {
    _tag = value;
  }
}
