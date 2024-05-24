import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/product%20view/bloc/product_view_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/models/category_model.dart';
import '../../products/models/product_model.dart';

class ProductViewCubit extends Cubit<ProductViewState>{
  final ProductModel product;
  late CategoryModel category;

  List<ProductModel> products = [];
  ProductViewCubit(this.product): super(ProductViewInitState());

  static ProductViewCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getCategory() async{
    Response response = await DioHelper.getData(
        url: '${Endpoint.categories}/${product.categoryId}'
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      category = CategoryModel.fromJson(response.data);
      emit(ProductViewCategorySuccessState());
    }
  }

  void getSimilarProducts()async{
    emit(ProductViewLoadingState());
    await getCategory();

    if(state is ProductViewCategorySuccessState){
      Response response = await DioHelper.getData(
        url: Endpoint.productsOfCategories + category.name,
        query: {'per_page': 3}
      ).catchError((error){
        return Response(requestOptions: RequestOptions(), statusCode: 400);
      });

      if(response.statusCode == 200 || response.statusCode == 201){
        response.data['data'].forEach((element){
          products.add(ProductModel.fromJson(element));
        });

        emit(ProductViewSuccessState());
      }

      else{
        emit(ProductViewErrorState());
      }
    }
  }
}