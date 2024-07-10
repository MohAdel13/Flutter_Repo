import 'package:chatty/core/style/colors.dart';
import 'package:chatty/features/comment/presentation/ui/comment_screen.dart';
import 'package:chatty/features/news%20feed/bloc/news_feed_cubit.dart';
import 'package:chatty/features/news%20feed/bloc/news_feed_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildPostItem extends StatelessWidget {
  final int index;

  BuildPostItem({
    required this.index
  });

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsFeedCubit, NewsFeedStates>(
      builder: (BuildContext context, NewsFeedStates state){
        NewsFeedCubit cubit = NewsFeedCubit.get(context);
        return Container(
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                offset: const Offset(-4.5, 4.5),
              ),
            ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: cubit.posts[index].image != ''? NetworkImage(
                        cubit.posts[index].image!,
                      ): null,
                    ),

                    const SizedBox(
                      width: 20.0,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.posts[index].name!,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            cubit.posts[index].dateTime!,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 20.0,
                    ),

                    IconButton(
                        onPressed: (){},
                        icon: const FaIcon(
                          FontAwesomeIcons.ellipsis,
                          color: Colors.grey,
                        )
                    )
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    cubit.posts[index].text!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                cubit.posts[index].postImage != null? Container(
                  height: 200.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(cubit.posts[index].postImage!),
                          fit: BoxFit.cover
                      )
                  ),
                ): const SizedBox.shrink(),

                Container(
                  color: Colors.grey.withOpacity(0.2),
                  height: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                ),

                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if(!cubit.posts[index].liked!){
                          cubit.addLike(index);
                        }
                        else{
                          cubit.removeLike(index);
                        }
                      },
                      child: Row(
                        children: [
                          !cubit.posts[index].liked! ? const FaIcon(FontAwesomeIcons.heart, color: Colors.grey,):
                          FaIcon(FontAwesomeIcons.solidHeart, color: mainColor,),
                          const SizedBox(width: 10.0,),
                          Text('${cubit.noOfLikes[index]}', style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: (){
                          cubit.getPostComments(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BlocProvider.value(
                                value: cubit,
                                child: CommentScreen(index: index),
                              )
                              )
                          );
                        },
                        child: Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.comment, color: Colors.grey,),
                              const SizedBox(width: 10.0,),
                              Text('${cubit.noOfComments[index]}', style: Theme.of(context).textTheme.titleSmall,),
                            ]
                        )
                    )
                  ],
                )
              ],
            ),

          ),
        );
      },
      listener: (BuildContext context, NewsFeedStates state){

      }
    );
  }
}
