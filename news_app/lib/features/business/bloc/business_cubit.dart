import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/remote/dio_helper.dart';
import 'business_states.dart';

class BusinessCubit extends Cubit<BusinessState>{
  BusinessCubit(): super(BusinessInitState());

  List businessData = [];

  static BusinessCubit get(BuildContext context) => BlocProvider.of(context);

  void getBusinessData()async{
    emit(BusinessLoadingState());
    await DioHelper.getData(category: 'business').then((value){
      businessData = value.data['articles'];
      print('Data Got Successfully...');
      emit(BusinessGetDataSuccessState());
    }).catchError((error) {
      emit(BusinessGetDataErrorState(error: error.toString()));
    });
  }
}