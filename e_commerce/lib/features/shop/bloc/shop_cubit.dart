import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/shop/bloc/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/models/product_model.dart';

class ShopCubit extends Cubit<ShopState>{
  ShopCubit(): super(ShopInitState());
  List<ProductModel> products = [];
  int? lastPage;
  int currentPage = 1;

  ScrollController scrollController = ScrollController();

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  void getInitialProducts()async{
    emit(ShopLoadingState());

    Response response = await getProducts();

    if(response.statusCode == 200 || response.statusCode == 201){
      await response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });

      lastPage = response.data['last_page'];

      currentPage++;
      emit(ShopSuccessState());
    }

    else{
      emit(ShopErrorState('Connection Failed..'));
    }
  }

  void scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(state is! ShopPaginationLoadingState){
          if(currentPage <= lastPage!){
            getMoreProducts();
          }
        }
      }
    });
  }

  Future<Response> getProducts()async{
    return await DioHelper.getData(
        url: Endpoint.products,
        query: {'page': currentPage}
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });
  }

  void getMoreProducts() async{
    emit(ShopPaginationLoadingState());

    Response response = await getProducts();

    if(response.statusCode == 200 || response.statusCode == 201){
      response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });

      currentPage++;

      emit(ShopPaginationSuccessState());
    }

    else{
      emit(ShopPaginationErrorState());
    }
  }
}