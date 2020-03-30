import 'dart:convert';

import 'package:aispeak/models/product_list_model.dart';
import 'package:aispeak/config/config.dart' as Config;
import 'package:http/http.dart' as http;

class ProductApi{


  static Future<ProductListModel> fetchList(int pageSize,int pageNo) async{
    final response = await http.get(Config.Config.queryProduct+'?pageNo=${pageNo}&pageSize=${pageSize}',
        headers: {'BSAuthorization':Config.Config.BSAuthorization});
    if( response.statusCode == 200){
      //解决中文乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      final json = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return ProductListModel.fromJson(json);
    }
    else
    {
      throw Exception('加载productlist接口失败');
    }
  }
}