import 'dart:collection';
import 'dart:convert';

import 'package:aispeak/config/config.dart';
import 'package:aispeak/models/Level_list_model.dart';
import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/models/product_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:http/http.dart' as http;

class ProductApi {

  static Future<ProductListModel> fetchList(String type, String category,
      int pageSize, int pageNo, String keyword,String orderby,String sort) async {
    LogUtil.init();
    Map<String, String> headers = new HashMap();
//    headers.putIfAbsent("Authorization", () => "Bearer");
    headers.putIfAbsent("content-type", () => "application/json");

    final response =
        await http.post(Config.queryProduct+"?type="+type+"&pageSize="+pageSize.toString()+"&pageNo="+pageNo.toString()+"&category="+category+"&order="+orderby+"&sort="+sort);
    if (response.statusCode == 200) {
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      print(json);
      return ProductListModel.fromJson(json);
    } else {
      throw Exception('加载product 接口失败：' + response.body);
    }
  }
  static Future<ProductModel> getProduct(String id) async {
    LogUtil.init();
    Map<String, Object> body = new HashMap();
    body.putIfAbsent("id", () => id);

    final putData = jsonEncode(body);
    print(putData);

    Map<String, String> headers = new HashMap();
//    headers.putIfAbsent("Authorization", () => "Bearer");
    headers.putIfAbsent("content-type", () => "application/json");

    final response =
        await http.post(Config.queryProductDetail+"?id="+id);
    if (response.statusCode == 200) {
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));

      return ProductModel.fromJson(json);
    } else {
      throw Exception('加载product 接口失败：' + response.body);
    }
  }
}
