import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/science/bloc/science_states.dart';

import '../../../core/network/remote/dio_helper.dart';

class ScienceCubit extends Cubit<ScienceState>{
  ScienceCubit(): super(ScienceInitState());

  List scienceData = [];
  
  static ScienceCubit get(BuildContext context) => BlocProvider.of(context);

  void getScienceData()async{
    emit(ScienceLoadingState());
    await DioHelper.getData(category: 'science').then((value){
      scienceData = value.data['articles'];
      print('Data Got Successfully...');
      emit(ScienceGetDataSuccessState());
    }).catchError((error) {
      emit(ScienceGetDataErrorState(error: error.toString()));
    });
  }
  
}