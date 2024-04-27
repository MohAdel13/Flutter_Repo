import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/artilces_list_widget.dart';
import 'package:news_app/features/search/bloc/search_cubit.dart';
import 'package:news_app/features/search/bloc/search_states.dart';
import 'package:news_app/features/search/presentation/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        builder: (BuildContext context, SearchState state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                SearchWidget(),
                const SizedBox(height: 40.0,),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is SearchOnErrorState,
                    builder: (context) => Expanded(child: Container()),
                    fallback: (context) => ConditionalBuilder(
                      condition: state is SearchLoadingState,
                      builder: (BuildContext context) => const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
                      fallback: (BuildContext context) => ArticlesListWidget(articles: cubit.searchData),
                    )
                  ),
                )
              ],
            ),
          );
        },
        listener: (BuildContext context, SearchState state) {  },

      ),
    );
  }

}