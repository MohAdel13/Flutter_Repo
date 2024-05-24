import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/home/models/category_model.dart';
import 'package:e_commerce/features/products/bloc/products_states.dart';
import 'package:e_commerce/features/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState>{
  ProductsCubit(this.category): super(ProductsInitState());

  CategoryModel category;
  int currentPage = 1;
  int? lastPage;
  ScrollController scrollController = ScrollController();

  List<ProductModel> products = [];

  static ProductsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<Response> getProducts() async{
    return await DioHelper.getData(
      url: Endpoint.productsOfCategories + category.name,
      query: {'page': currentPage}
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });
  }

  void getInitialProducts() async{
    emit(ProductsLoadingState());

    Response response = await getProducts();

    if(response.statusCode == 200 || response.statusCode == 201){
      response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });
      lastPage = response.data['last_page'];

      currentPage++;
      emit(ProductsSuccessState());
    }

    else{
      emit(ProductsErrorState('Connection failed..'));
    }
  }

  void getMoreProducts() async{
    emit(ProductsPaginationLoadingState());

    Response response = await getProducts();

    if(response.statusCode == 200 || response.statusCode == 201){
      response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });

      currentPage++;
      emit(ProductsPaginationSuccessState());
    }

    else{
      emit(ProductsPaginationErrorState());
    }
  }

  void scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(state is! ProductsPaginationLoadingState){
          if(currentPage <= lastPage!){
            getMoreProducts();
          }
        }
      }
    });
  }
}