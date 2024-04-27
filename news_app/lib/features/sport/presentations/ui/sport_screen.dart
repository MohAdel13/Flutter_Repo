import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/artilces_list_widget.dart';
import 'package:news_app/features/sport/bloc/sport_cubit.dart';
import 'package:news_app/features/sport/bloc/sport_states.dart';

class SportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SportCubit()..getSportData(),
      child: BlocConsumer<SportCubit, SportState>(
        builder: (BuildContext context, SportState state) {
          SportCubit cubit = SportCubit.get(context);
          if(state is SportLoadingState){
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
            );
          }
          else{
            return ArticlesListWidget(articles: cubit.sportData);
          }
        },
        listener: (BuildContext context, SportState state) {
          if(state is SportGetDataErrorState){
            print(state.error);
          }
        },
      ),
    );
  }
}
