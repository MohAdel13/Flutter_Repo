import 'package:e_commerce/features/shop/bloc/shop_cubit.dart';
import 'package:e_commerce/features/shop/bloc/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/widgets/build_product_item.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      ShopCubit()..getInitialProducts()..scrollControllerListener(),
      child: BlocConsumer<ShopCubit, ShopState>(
          listener: (BuildContext context, ShopState state) {},
          builder: (BuildContext context, ShopState state) {
            ShopCubit cubit = ShopCubit.get(context);

            if (state is ShopLoadingState) {
              EasyLoading.show();
            }
            else if (state is ShopErrorState) {
              EasyLoading.showError(state.error);
            }
            else {
              EasyLoading.dismiss();
              return SingleChildScrollView(
                controller: cubit.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)
                          )
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/images/offer.jpg', fit: BoxFit.fill,),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 20.0, left: 20.0),
                      child: const Text(
                        'Shop now to get your offer',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
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
                    state is ShopPaginationLoadingState? const Center(
                      child: CircularProgressIndicator(),):
                    const SizedBox.shrink()
                  ],
                ),
              );
            }

            return Container();
          }
      ),
    );
  }
}

