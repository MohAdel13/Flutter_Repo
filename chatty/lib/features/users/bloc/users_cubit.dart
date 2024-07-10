import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/login/models/user_model.dart';
import 'package:chatty/features/users/bloc/users_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersStates>{
  UsersCubit(): super(UsersInitState());

  List<UserModel> users = [];

  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  void getUsers()async {
    emit(UsersLoadingState());

    String? userId = CacheHelper.getData('token') as String?;

    await FirebaseFirestore.instance.collection('users')
        .get().then((value){
          for (var user in value.docs) {
            if(user.id != userId){
              users.add(UserModel.fromJson(user.data()));
            }
          }
    });
    emit(UsersSuccessState());
  }

  void follow(int index)async{
    emit(UsersFollowLoadingState());

    String? userId = CacheHelper.getData('token') as String?;

    await FirebaseFirestore.instance.collection('users')
      .doc(userId).collection('following')
      .doc(users[index].uId).set({userId!: true}
    ).then((value){
      emit(UsersFollowSuccessState());
    }).catchError((error){
      emit(UsersFollowErrorState());
    });
  }
}