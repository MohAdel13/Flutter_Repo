import 'package:e_commerce/core/style/colors.dart';
import 'package:e_commerce/features/home/models/category_model.dart';
import 'package:e_commerce/features/products/bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/widgets/build_product_item.dart';
import '../../bloc/products_states.dart';
class ProductsScreen extends StatelessWidget {
  final CategoryModel category;
  ProductsScreen({required this.category});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProductsCubit(category)..getInitialProducts()..scrollControllerListener(),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        builder: (BuildContext context, ProductsState state) {
          ProductsCubit cubit = ProductsCubit.get(context);

          if (state is ProductsLoadingState) {
            EasyLoading.show();
          } else if (state is ProductsErrorState) {
            EasyLoading.showError(state.error);
          } else {
            EasyLoading.dismiss();
            return Scaffold(
              body: SingleChildScrollView(
                controller: cubit.scrollController,
                child: Column(
                  children: [
                    Container(
                        color: mainColor.withOpacity(0.05),
                        height: 180,
                        width: double.infinity,
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Image.network(category.avatar,)
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                    Container(
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

                    state is ProductsPaginationLoadingState? const Center(child: CircularProgressIndicator(),):
                    const SizedBox.shrink()
                  ],
                ),
              ),
            );
          }

          return Container();
        },
        listener: (BuildContext context, ProductsState state) {},
      )
    );
  }
}
