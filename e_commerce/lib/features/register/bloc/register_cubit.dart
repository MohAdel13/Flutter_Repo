import 'package:dio/dio.dart';
import 'package:e_commerce/features/login/presentation/ui/login_screen.dart';
import 'package:e_commerce/features/register/bloc/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/remote/dio_helper.dart';
import '../../../core/network/remote/endpoints.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit(): super(RegisterInitState());
  bool passObscure = true;
  bool confPassObscure = true;


  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  void changePassVisibility(){
    passObscure = !passObscure;
    emit(RegisterPassVisibilityState());
  }

  void changeConfPassVisibility(){
    confPassObscure = !confPassObscure;
    emit(RegisterConfPassVisibilityState());
  }

  void register({
    required String email,
    required String name,
    required String phone,
    required String password,
    required String confPassword,
    required BuildContext context

  })async{
    emit(RegisterLoadingState());

    Response response = await DioHelper.postData(
      url: Endpoint.register,
      data: {
        'email': '$email',
        'password': '$password',
        'name': '$name',
        'phone': '$phone',
        'password_confirmation': '$confPassword'
      }
    ).catchError((error){
      emit(RegisterErrorState("Register failed..."));
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      emit(RegisterSuccessState());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false
      );
    }
    else{
      emit(RegisterErrorState("Register failed..."));
    }
  }
}