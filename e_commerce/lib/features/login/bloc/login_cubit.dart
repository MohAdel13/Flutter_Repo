import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/network/remote/endpoints.dart';
import 'package:e_commerce/features/login/models/user_access_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../shop_layout/presentation/ui/shop_layout_screen.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(LoginInitState());
  bool obscure = true;

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void changePassVisibility(){
    obscure = !obscure;
    emit(LoginPassVisibilityState());
  }

  void login({
    required String email,
    required String password,
    required BuildContext context
  })async{
    emit(LoginLoadingState());

    Response response = await DioHelper.postData(
      url: Endpoint.login,
      data: {'email': '$email', 'password': '$password'}
    ).catchError((error){
      emit(LoginErrorState("Login failed..."));
      return Response(requestOptions: RequestOptions(), statusCode: 400);
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      UserAccessModel userAccessModel = UserAccessModel.fromJson(response.data);
      emit(LoginSuccessState());
      await userSave(context, userAccessModel.accessToken);
    }
    else{
      emit(LoginErrorState("Login failed..."));
    }
  }

  Future<void> userSave(BuildContext context, String token)async {
    CacheHelper.setData('token', token).then((value){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShopLayoutScreen()),
              (route) => false
      );
    });
  }
}