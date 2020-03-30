import 'package:aispeak/models/BannerData.dart';

class BannerListModel {
  String _code;
  String _mesg;
  List<BannerData> _data;

  BannerListModel({String code, String mesg, List<BannerData> data}) {
    this.code = code;
    this._data = data;
    this._mesg = mesg;
  }

  String get code => _code;

  set code(String code) => code = _code;

  String get mesg => _mesg;

  set mesg(String mesg) => mesg = _mesg;

  List<BannerData> get data => _data;

  set data(List<BannerData> data) => _data = data;

  BannerListModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['datas'] != null) {
      _data = new List<BannerData>();
      json['datas'].forEach((v) {
        _data.add(new BannerData.fromJson(v));
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
