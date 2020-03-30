import 'package:aispeak/models/LevelData.dart';

class LevelListModel {
  String _code;
  String _mesg;
  List<LevelData> _data;

  LevelListModel({String code, String mesg, List<LevelData> data}) {
    this.code = code;
    this._data = data;
    this._mesg = mesg;
  }

  String get code => _code;

  set code(String code) => code = _code;

  String get mesg => _mesg;

  set mesg(String mesg) => mesg = _mesg;

  List<LevelData> get data => _data;

  set data(List<LevelData> data) => _data = data;

  LevelListModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['data'] != null) {
      _data = new List<LevelData>();
      json['data'].forEach((v) {
        _data.add(new LevelData.fromJson(v));
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
