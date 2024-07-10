import 'package:chatty/features/comment/models/comment_model.dart';
import 'package:chatty/features/comment/presentation/widgets/comment_item_widget.dart';
import 'package:chatty/features/news%20feed/bloc/news_feed_cubit.dart';
import 'package:chatty/features/news%20feed/bloc/news_feed_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/style/colors.dart';

class CommentScreen extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  final int index;

  CommentScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocConsumer<NewsFeedCubit, NewsFeedStates>(
        builder: (BuildContext context, NewsFeedStates state){
          NewsFeedCubit cubit = NewsFeedCubit.get(context);
          if(state is CommentsLoadingState){
            EasyLoading.show();
            return Container(color: Colors.white,);
          }
          else if(state is CommentsErrorState){
            EasyLoading.showError('Error happened');
            return Container(color: Colors.white,);
          }
          else{
            EasyLoading.dismiss();
          }
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        child: TextFormField(
                          controller: textController,
                          maxLines: 2,
                          decoration: InputDecoration(
                              hintText: 'Write Your Comment...',
                              hintStyle: Theme.of(context).textTheme.titleSmall,
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8.0),

                    (state is! NewsFeedCommentAddLoadingState)?FloatingActionButton(
                      onPressed: () async{
                        CommentModel comment = CommentModel(
                          userId: cubit.userId,
                          text: textController.text,
                        );

                        comment.userImage = await FirebaseFirestore.instance.collection('users')
                          .doc(cubit.userId).get().then((value){
                            return (value.data() as Map<String, dynamic>)['image'];
                        });

                        comment.userName = await FirebaseFirestore.instance.collection('users')
                            .doc(cubit.userId).get().then((value){
                          return (value.data() as Map<String, dynamic>)['name'];
                        });

                        cubit.addComment(comment, index);
                        textController.clear();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: mainColor,
                      ),
                    ): CircularProgressIndicator(color: mainColor,),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, ind) => CommentItemWidget(comment: cubit.commentsList[index][ind]),
                  separatorBuilder: (context, ind) => Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(color: Colors.grey, height: 1.0,),
                  ),
                  itemCount: cubit.commentsList[index].length
                ),
              )
            ],
          );
        },

        listener: (BuildContext context, NewsFeedStates state){},
      ),
    );
  }
}
