import 'dart:collection';
import 'dart:convert';

import 'package:aispeak/models/BannerListModel.dart';
import 'package:aispeak/config/config.dart';
import 'package:http/http.dart' as http;

class BannerApi {
  static Future<BannerListModel> fetchList() async {
    Map<String, Object> body = new HashMap();
    body.putIfAbsent("type", () => "01");

    final putData = jsonEncode(body);

    Map<String, String> headers = new HashMap();
    headers.putIfAbsent("Authorization", () => "Bearer");
    headers.putIfAbsent("content-type", () => "application/json");

    final response =
        await http.get(Config.bannerList+"?type=01", headers: headers);
    if (response.statusCode == 200) {
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return BannerListModel.fromJson(json);
    } else {
      throw Exception('加载Banner接口失败：' + response.body);
    }
  }
}
