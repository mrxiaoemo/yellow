class BannerData {
  String _url;
  String _title;
  String _cover;
  String _type;

  BannerData( {
    String url,
    String title,
    String image,
    String type,
  })

  {
    this._title = title;
    this._cover = image;
    this._url = url;
    this._type = type;
  }


  BannerData.fromJson(
      Map<String, dynamic> json)

  {
    _url= json['url'];
    _title = json['title'];
    _cover = json['image'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this._url;
    data['title'] = this._title;
    data['image'] = this._cover;
    data['type'] = this._type;
    return data;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get image => _cover;

  set image(String value) {
    _cover = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

}
