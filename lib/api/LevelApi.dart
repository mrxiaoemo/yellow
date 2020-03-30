import 'dart:collection';
import 'dart:convert';

import 'package:aispeak/models/Level_list_model.dart';
import 'package:aispeak/config/config.dart' as Config;
import 'package:http/http.dart' as http;

class LevelApi {
  static Future<LevelListModel> fetchList(
      int pageSize, int pageNo, String type, String free) async {
    Map<String, Object> body = new HashMap();
    body.putIfAbsent("pageNo", () => pageNo.toString());
    body.putIfAbsent("pageSize", () => pageSize.toString());
    body.putIfAbsent("type", () => type);
    body.putIfAbsent("free", () => free);

    final putData = jsonEncode(body);

    Map<String, String> headers = new HashMap();
    headers.putIfAbsent("Authorization", () => "Bearer");
    headers.putIfAbsent("content-type", () => "application/json");

    final response =
        await http.post(Config.Config.level, headers: headers, body: putData);
    if (response.statusCode == 200) {
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return LevelListModel.fromJson(json);
    } else {
      throw Exception('加载level接口失败：' + response.body);
    }
  }
}
