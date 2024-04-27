import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/features/search/bloc/search_states.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(): super(SearchInitState());


  List searchData = [];
  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getSearch(String value)async{
    emit(SearchLoadingState());
    searchData = await DioHelper.getSearchData(value: value).then((value){
      emit(SearchChangeState());
      return value.data['articles'];
    }).catchError((error){
      print("Error happened while getting data...");
      emit(SearchOnErrorState());
    });
  }
}