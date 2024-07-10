import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/add%20post/models/post_model.dart';
import 'package:chatty/features/comment/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/models/user_model.dart';
import 'news_feed_states.dart';

class NewsFeedCubit extends Cubit<NewsFeedStates>{
  NewsFeedCubit(): super(NewsFeedInitState());

  late List<PostModel> posts = [];
  List<int> noOfLikes = [];
  List<bool> likesList = [];
  List<int> noOfComments = [];
  List<List<CommentModel>> commentsList = [];
  late final String? userId;

  static NewsFeedCubit get(BuildContext context) => BlocProvider.of(context);

  void getPosts()async{
    emit(NewsFeedLoadingState());

    userId = CacheHelper.getData('token') as String?;

    await FirebaseFirestore.instance.collection('posts')
        .get().then((value) async {
      for (var element in value.docs) {
        await element.reference.collection('likes').get().then((v)async{
          int likes = v.size;
          noOfLikes.add(likes);
          likesList.add(false);
          if(likes > 0){
            if(v.docs.contains(userId)){
              if(await v.docs.single.get(userId!)){
                likesList[likesList.length - 1] = true;
              }
            }
          }
        });

        await element.reference.collection('comments').get().then((v){
          noOfComments.add(v.size);
          commentsList.add([]);
          for(var comment in v.docs){
            commentsList[commentsList.length - 1].add(CommentModel.fromJson(comment.data()));
          }
        });

        posts.add(PostModel.fromJson(element.data()));

        posts[posts.length - 1].liked = likesList[likesList.length - 1];
        posts[posts.length - 1].postId = element.id;

        await FirebaseFirestore.instance.collection('users')
            .doc(posts[posts.length - 1].uId).get()
            .then((v){
           UserModel user = UserModel.fromJson(v.data() as Map<String, dynamic>);
           posts[posts.length - 1].name = user.name;
           posts[posts.length - 1].image = user.image;
        });
      }
      emit(NewsFeedSuccessState());
    }).catchError((error){
      emit(NewsFeedErrorState());
      print(error);
    });
  }

  void addLike(int index)async{
    await FirebaseFirestore.instance.collection('posts').doc(posts[index].postId)
        .collection('likes').doc(userId).set({userId!: true})
        .then((value){
          noOfLikes[index]++;
          posts[index].liked = true;
          emit(NewsFeedLikesAddState());
    });
  }

  void removeLike(int index)async{
    await FirebaseFirestore.instance.collection('posts').doc(posts[index].postId)
        .collection('likes').doc(userId).delete()
        .then((value){
          noOfLikes[index]--;
          posts[index].liked = false;
          emit(NewsFeedLikesRemoveState());
    });
  }

  void addComment(CommentModel comment, int index)async{
    emit(NewsFeedCommentAddLoadingState());

    await FirebaseFirestore.instance.collection('posts').doc(posts[index].postId)
        .collection('comments').add(comment.toJson());

    commentsList[index].add(comment);

    emit(NewsFeedCommentAddSuccessState());
  }

  void getPostComments(int index)async{
    emit(CommentsLoadingState());

    for(int i = 0; i<commentsList[index].length; i++){
      await FirebaseFirestore.instance.collection('users')
          .doc(commentsList[index][i].userId).get().then((value){
            commentsList[index][i].userName = (value.data() as Map<String, dynamic>)['name'];
            commentsList[index][i].userImage = (value.data() as Map<String, dynamic>)['image'];
      });
    }

    emit(CommentsSuccessState());
  }
}