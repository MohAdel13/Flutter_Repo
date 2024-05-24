import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';

class DioHelper{
  static late Dio dio;

  static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoint.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}
      )
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
}){
    return dio.post(url, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic> query = const <String, dynamic>{}
  }){
    return dio.get(url, queryParameters: query);
  }

}