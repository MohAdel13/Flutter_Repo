import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/widgets/artilces_list_widget.dart';
import 'package:news_app/features/business/bloc/business_cubit.dart';
import 'package:news_app/features/business/bloc/business_states.dart';


class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BusinessCubit()..getBusinessData(),
      child: BlocConsumer<BusinessCubit, BusinessState>(
        builder: (BuildContext context, BusinessState state) {
          BusinessCubit cubit = BusinessCubit.get(context);
          if(state is BusinessLoadingState){
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange,),
            );
          }
          else{
            return ArticlesListWidget(articles: cubit.businessData);
          }
        },
        listener: (BuildContext context, BusinessState state) {
          if(state is BusinessGetDataErrorState){
            print(state.error);
          }
        },
      ),
    );
  }
}
