import 'dart:convert';

import 'package:aispeak/models/product_list_model.dart';

class Config {
  static const BSAuthorization = 'C2B92CBAA2B92328A330DC3D50B73CEE';
  static const BaseURL = 'http://198.44.191.21:8670/api';
 // static const BaseURL = 'http://192.168.1.74:8670/api';

  static const postLogin = BaseURL + "/user/login";
  static const loginWeixin = BaseURL + "/user/loginWeixin";
  static const loginQq = BaseURL + "/user/loginQq";
  static const sendVerifyCode = BaseURL + "/user/sendVerifyCode";


  static const queryProduct = BaseURL + "/product/queryProduct";
  static const queryProductDetail = BaseURL + "/product/detail";
  static const bannerList = BaseURL + "/banner/list";


  static const level = BaseURL + "open/level";
}
