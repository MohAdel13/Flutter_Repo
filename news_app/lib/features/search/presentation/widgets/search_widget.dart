import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/bloc/search_cubit.dart';
import 'package:news_app/features/search/bloc/search_states.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      builder: (BuildContext context, SearchState state){
        SearchCubit cubit = SearchCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.deepOrange,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.deepOrange),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              labelText: 'Search',
              labelStyle: const TextStyle(color: Colors.deepOrangeAccent, ),
            ),
            cursorColor: Colors.deepOrange,
            style: Theme.of(context).textTheme.headline1,
            onFieldSubmitted: (value)async{
              await cubit.getSearch(searchController.text);
            },
          ),
        );
      },
      listener: (BuildContext context, SearchState state) {  },
    );
  }
}
