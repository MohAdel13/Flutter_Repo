import 'dart:io';

import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/add%20post/bloc/add_post_states.dart';
import 'package:chatty/features/add%20post/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../login/models/user_model.dart';

class AddPostCubit extends Cubit<AddPostStates>{
  AddPostCubit(): super(AddPostInitState());

  late UserModel user;
  File? image;

  static AddPostCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getUser() async {
    emit(AddPostLoadingState());

    String token = CacheHelper.getData('token') as String;

    await FirebaseFirestore.instance.collection('users')
        .doc(token).get().then((value){
          user = UserModel.fromJson(value.data() as Map<String, dynamic>);
          emit(AddPostSuccessState());
    }).catchError((error){
      emit(AddPostErrorState());
    });

  }

  void addPhoto(){
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value){
      image = File(value!.path);
      emit(AddPostPhotoSuccessState());
    }).catchError((error){
      emit(AddPostPhotoErrorState());
    });
  }

  Future<String> uploadImage()async{
    String retValue = "";
    await FirebaseStorage.instance.ref()
      .child('posts/${Uri.file(image!.path).pathSegments.last}')
      .putFile(image!).catchError((error){
        emit(AddPostPhotoUploadErrorState());
    });

    await FirebaseStorage.instance.ref()
      .child('posts/${Uri.file(image!.path).pathSegments.last}')
      .getDownloadURL().then((value){
        retValue = value;
        emit(AddPostPhotoUploadSuccessState());
    }).catchError((error){
      emit(AddPostPhotoUploadErrorState());
    });

    return retValue;
  }

  void createPost({
    required String text,
  })async{

    emit(AddPostCreatedLoadingState());
    String? postImage;

    if(image != null){
       postImage = await uploadImage();
    }

    PostModel post = PostModel(
      uId: user.uId,
      dateTime: DateTime.now().toString(),
      text: text,
      postImage: postImage
    );

    await FirebaseFirestore.instance.collection('posts')
      .add(post.toJson()).then((value){
        emit(AddPostCreatedSuccessState());
    }).catchError((error){
      emit(AddPostCreatedErrorState());
    });

  }

  void deletePhoto(){
    image = null;
    emit(AddPostDeletePhotoAddedState());
  }


}