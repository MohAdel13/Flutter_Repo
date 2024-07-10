import 'package:chatty/features/home%20layout/presentation/ui/home_layout_screen.dart';
import 'package:chatty/features/login/bloc/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginInitState());

  bool obscure = true;

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void login({required String email, required String password, required BuildContext context})async{
    emit(LoginLoadingState());
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password
      );

      String? token = credential.user?.uid;
      await CacheHelper.setData('token', token);

      emit(LoginSuccessState());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeLayoutScreen())
      );

    }on FirebaseAuthException catch(e){
      emit(LoginErrorState(e.message));
    }
  }

  void changePassVisibility(){
    obscure = !obscure;
    emit(LoginVisibilityChangeState());
  }
}