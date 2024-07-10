import 'dart:io';

import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/settings/bloc/settings_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../login/models/user_model.dart';

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit(): super(SettingsInitState());

  late UserModel user;
  File? profileImage;
  File? coverImage;

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);

  void getUser()async{
    emit(SettingsLoadingState());
    String token = CacheHelper.getData('token') as String;
    await FirebaseFirestore.instance.collection('users').doc(token).get().then((value){
      user = UserModel.fromJson(value.data() as Map<String, dynamic>);
      emit(SettingsSuccessState());
    }).catchError((error){
      emit(SettingsErrorState());
    });
  }

  void changeProfileImage(){
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value){
      profileImage = File(value!.path);
      emit(SettingsProfileImageChangeSuccessState());
    }).catchError((error){
      emit(SettingsProfileImageChangeErrorState());
    });
  }

  void changeCoverImage(){
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value){
      coverImage = File(value!.path);
      emit(SettingsCoverImageChangeSuccessState());
    }).catchError((error){
      emit(SettingsCoverImageChangeErrorState());
    });
  }

  Future<String> uploadProfileImage()async{
    String retValue = "";
    UploadTask task = FirebaseStorage.instance.ref()
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!);

    await task.storage.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .getDownloadURL().then((value){
      retValue = value;
    }).catchError((error){
      emit(SettingsUserUpdateErrorState());
    });

    return retValue;
  }

  Future<String> uploadCoverImage() async{
    String retValue = "";
    UploadTask task = FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!);

    await task.storage.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .getDownloadURL()
        .then((value){
      retValue = value;
    }).catchError((error){
      emit(SettingsUserUpdateErrorState());
    });

    return retValue;
  }

  void updateUser({required String phone, required String name})async{
    emit(SettingsUserUpdateLoadingState());
    UserModel newUser = user;
    newUser.phone = phone;
    newUser.name = name;
    if(coverImage != null){
      String cover = await uploadCoverImage();
      if(cover != ""){
        newUser.coverImage = cover;
      }
      else{
        return;
      }
    }
    if(profileImage != null){
      String profile = await uploadProfileImage();
      if(profile != ""){
        newUser.image = profile;
      }
      else{
        return;
      }
    }
    FirebaseFirestore.instance.collection('users')
        .doc(user.uId).update(user.toJson())
        .then((value){
          user = newUser;
          print(user.coverImage);
          emit(SettingsUserUpdateSuccessState());
    }).catchError((error){
      emit(SettingsUserUpdateErrorState());
    });
  }
}