import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/news_feed_cubit.dart';
import '../../bloc/news_feed_states.dart';
import '../widgets/build_post_item.dart';

class NewsFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsFeedCubit()..getPosts(),
      child: BlocConsumer<NewsFeedCubit, NewsFeedStates>(builder: (
        BuildContext context, NewsFeedStates state) {
          NewsFeedCubit cubit = NewsFeedCubit.get(context);
          if(state is NewsFeedLoadingState){
            EasyLoading.show();
            return Container(color: Colors.white,);
          }
          else if(state is NewsFeedErrorState){
            EasyLoading.showError('Error happened');
            return Container(color: Colors.white,);
          }
          else{
            EasyLoading.dismiss();
          }
          return SingleChildScrollView(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => BlocProvider.value(
                      value: cubit, child: BuildPostItem(
                      index: index,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 10,),
                  itemCount: cubit.posts.length
              )
          );
        },
        listener: (BuildContext context, NewsFeedStates state) {  },

      ),
    );
  }
}
