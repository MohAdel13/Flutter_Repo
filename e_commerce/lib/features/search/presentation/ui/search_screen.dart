import 'package:e_commerce/core/widgets/search_text_form_field.dart';
import 'package:e_commerce/features/search/bloc/search_cubit.dart';
import 'package:e_commerce/features/search/bloc/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/widgets/build_product_item.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit()..scrollControllerListener(),
      child: BlocConsumer<SearchCubit, SearchState>(
          listener: (BuildContext context, SearchState state) {},
          builder: (BuildContext context, SearchState state) {
            SearchCubit cubit = SearchCubit.get(context);

            if (state is SearchLoadingState) {
              EasyLoading.show();
            }
            else if (state is SearchErrorState) {
              EasyLoading.showError(state.error);
            }
            else {
              EasyLoading.dismiss();
            }

            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100.0,),
              
                  SearchTextFormField(
                    onChanged: (value){
                      cubit.getInitialProducts(value);
                    },
              
                    autofocus: true,
                  ),
              
                  const SizedBox(height: 15.0,),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: cubit.scrollController,
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 20.0, left: 20.0, right: 20.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              BuildProductItem(product: cubit.products[index]),
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 20.0,),
                          itemCount: cubit.products.length
                        ),
                      ),
                    ),
                  ),
                  state is SearchPaginationLoadingState? const Center(child: CircularProgressIndicator(),):
                      const SizedBox.shrink()
                ],
              ),
            );
          }
      ),
    );
  }
}
