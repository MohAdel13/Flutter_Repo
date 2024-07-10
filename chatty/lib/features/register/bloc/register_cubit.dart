import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/login/models/user_model.dart';
import 'package:chatty/features/register/bloc/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home layout/presentation/ui/home_layout_screen.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit(): super(RegisterInitState());

  bool confPassObscure = true;
  bool passObscure = true;

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  void register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context
  })async{
    emit(RegisterLoadingState());

    try{

      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password
      );

      String? token = credential.user?.uid;
      await CacheHelper.setData('token', token);

      userCreate(
        email: email, phone: phone, name: name, uId: token!
      ).then((value){
        emit(RegisterSuccessState());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeLayoutScreen())
        );
      }).catchError((error){
        emit(RegisterErrorState(error.toString()));
      });

    }on FirebaseAuthException catch (e){
      emit(RegisterErrorState(e.message));
    }
  }

  void changeConfPassVisibility(){
    confPassObscure = !confPassObscure;
    emit(RegisterConfPassVisibilityChangeState());
  }

  void changePassVisibility(){
    passObscure = !passObscure;
    emit(RegisterVisibilityChangeState());
  }

  Future<void> userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId
  }) async
  {
    UserModel user = UserModel(
      name: name, email: email,
      uId: uId,
      phone: phone,
      image: 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      coverImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmk9EJWQdMrBcMVGjUGgwBYOKW5GW3sNRPmcqltC171A&s'
    );
    return FirebaseFirestore.instance.collection('users').doc(uId).set(user.toJson());
  }
}