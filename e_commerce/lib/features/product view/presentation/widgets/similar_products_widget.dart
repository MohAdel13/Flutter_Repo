import 'package:e_commerce/features/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/presentation/ui/products_screen.dart';
import 'build_similar_product_item.dart';
import '../../bloc/product_view_cubit.dart';
import '../../bloc/product_view_states.dart';

class SimilarProductsWidget extends StatelessWidget {
  final ProductModel product;
  const SimilarProductsWidget(this.product);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductViewCubit(product)..getSimilarProducts(),
        child: BlocConsumer<ProductViewCubit, ProductViewState>(
          builder: (BuildContext context, ProductViewState state) {
            ProductViewCubit cubit = ProductViewCubit.get(context);
            if (state is ProductViewSuccessState) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        const Text("Similar Products:", style: TextStyle(color: Colors.black, fontSize: 16.0),),
                        const Spacer(),
                        TextButton(
                          child: const Text('Show All'),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsScreen(category: cubit.category)
                                )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 350.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Container(
                          width: 200.0,
                          margin: const EdgeInsets.all(20.0),
                          child: BuildSimilarProductItem(product: cubit.products[index],)
                      ),
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 50.0,),
                      itemCount: 3,
                    ),
                  ),
                ],
              );
            } else {
              return (state is ProductViewCategorySuccessState || state is ProductViewLoadingState)?
              const Center(child: CircularProgressIndicator(),): const SizedBox.shrink();
            }
          },
          listener: (BuildContext context, ProductViewState state) {  },

        )
    );
  }
}
