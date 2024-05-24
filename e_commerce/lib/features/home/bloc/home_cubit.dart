import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/home/bloc/home_states.dart';
import 'package:e_commerce/features/home/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit(): super(HomeInitState());

  int currentPage = 1;

  int? lastPage;

  List<CategoryModel> categories = [];

  ScrollController scrollController = ScrollController();

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  Future<Response> getCategories()async{
    return await DioHelper.getData(
      url: Endpoint.categories,
      query: {'page': currentPage}
    ).catchError((error){
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });
  }

  void getInitialCategories() async{
    emit(HomeLoadingState());

    Response response = await getCategories();

    if(response.statusCode == 200 || response.statusCode == 201){
      response.data['data'].forEach((element){
        categories.add(CategoryModel.fromJson(element));
      });

      lastPage = response.data['last_page'];

      currentPage++;
      emit(HomeSuccessState());
    }

    else{
      emit(HomeErrorState('Connection failed..'));
    }
  }

  void getMoreCategories() async{
    emit(HomePaginationLoadingState());

    Response response = await getCategories();

    if(response.statusCode == 200 || response.statusCode == 201){
      response.data['data'].forEach((element){
        categories.add(CategoryModel.fromJson(element));
      });

      currentPage++;
      emit(HomePaginationSuccessState());
    }

    else{
      emit(HomePaginationErrorState());
    }
  }

  void scrollControllerListener(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        if(state is! HomePaginationLoadingState){
          if(currentPage <= lastPage!){
            getMoreCategories();
          }
        }
      }
    });
  }
}