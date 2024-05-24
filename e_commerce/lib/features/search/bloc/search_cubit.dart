import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/products/models/product_model.dart';
import 'package:e_commerce/features/search/bloc/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(): super(SearchInitState());
  List<ProductModel> products = [];

  ScrollController scrollController = ScrollController();

  int currentPage = 1;

  int? lastPage;

  String keyword = '';

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  void getInitialProducts(String keyword)async{
    currentPage = 1;
    this.keyword = keyword;
    emit(SearchLoadingState());

    Response response = await DioHelper.getData(
        url: Endpoint.products,
        query: {'keyword': '$keyword', 'page': currentPage}
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      products = [];
      await response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });

      lastPage = response.data['last_page'];

      currentPage++;
      emit(SearchSuccessState());
    }

    else{
      emit(SearchErrorState('Connection failed..'));
    }

  }

  void getMoreProducts() async{
    emit(SearchPaginationLoadingState());

    Response response = await DioHelper.getData(
        url: Endpoint.products,
        query: {'keyword': '$keyword', 'page': currentPage}
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      await response.data['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });

      currentPage++;
      emit(SearchPaginationSuccessState());
    }

    else{
      emit(SearchPaginationErrorState());
    }
  }

  void scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(state is! SearchPaginationLoadingState){
          if(currentPage <= lastPage!){
            getMoreProducts();
          }
        }
      }
    });
  }
}