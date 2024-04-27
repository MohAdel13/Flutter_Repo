import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/sport/bloc/sport_states.dart';
import '../../../core/network/remote/dio_helper.dart';

class SportCubit extends Cubit<SportState>{
  SportCubit(): super(SportInitState());

  List sportData = [];
  
  static SportCubit get(BuildContext context) => BlocProvider.of(context);

  void getSportData()async{
    emit(SportLoadingState());
    await DioHelper.getData(category: 'sport').then((value){
      sportData = value.data['articles'];
      print('Data Got Successfully...');
      emit(SportGetDataSuccessState());
    }).catchError((error) {
      emit(SportGetDataErrorState(error: error.toString()));
    });
  }
}