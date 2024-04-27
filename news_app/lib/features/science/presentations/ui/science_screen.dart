import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/artilces_list_widget.dart';
import 'package:news_app/features/science/bloc/science_cubit.dart';
import 'package:news_app/features/science/bloc/science_states.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ScienceCubit()..getScienceData(),
      child: BlocConsumer<ScienceCubit, ScienceState>(
        builder: (BuildContext context, ScienceState state) {
          ScienceCubit cubit = ScienceCubit.get(context);
          if(state is ScienceLoadingState){
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
            );
          }
          else{
            return ArticlesListWidget(articles: cubit.scienceData);
          }
        },
        listener: (BuildContext context, ScienceState state) {
          if(state is ScienceGetDataErrorState){
            print(state.error);
          }
        },
      ),
    );
  }
}
