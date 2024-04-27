import 'package:dio/dio.dart';

import 'endpoints.dart';

class DioHelper{

  static late Dio dio;
  static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoint.baseUrl,
        receiveDataWhenStatusError: true
      )
    );
  }

  static Future<Response> getData({required String category})async{
    return await dio.get(Endpoint.topHeadlinesEndpoint, queryParameters: Endpoint.getQuery(category: category)).then((value){
      print(value.data['articles'].toString());
      return value;
    }).catchError((error){
      print('Error while getting data: ${error.toString()}');
    });
  }

  static Future<Response> getSearchData({required String value})async{
    return await dio.get(Endpoint.everythingEndpoint, queryParameters: Endpoint.getSearchQuery(value: value)).then((value){
      print(value.data["articles"].toString());
      return value;
    }).catchError((error){
      print('Error while getting data: ${error.toString()}');
    });
  }
}