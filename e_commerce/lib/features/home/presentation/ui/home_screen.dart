import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/widgets/search_text_form_field.dart';
import 'package:e_commerce/features/home/bloc/home_cubit.dart';
import 'package:e_commerce/features/home/presentation/widgets/carousel_item_widget.dart';
import 'package:e_commerce/features/search/presentation/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/home_states.dart';
import '../widgets/build_category_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getInitialCategories()..scrollControllerListener(),
      child: BlocConsumer<HomeCubit, HomeState>(

        builder: (BuildContext context, HomeState state) {
          HomeCubit cubit = HomeCubit.get(context);

          if(state is HomeLoadingState){
            EasyLoading.show();
          }
          else if(state is HomeErrorState){
            EasyLoading.showError(state.error);
          }
          else{
            EasyLoading.dismiss();
            return  SingleChildScrollView(
              controller: cubit.scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height:130.0,
                    child: Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: Alignment.topCenter,
                          height:95.0,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0)
                              )
                          ),
                          child: Image.asset('assets/images/home_image.png'),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SearchTextFormField(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SearchScreen()));
                            },
                            readOnly: true,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30.0,),

                  CarouselSlider(
                    items: const [
                      CarouselItemWidget('assets/images/slider.jpg'),
                      CarouselItemWidget('assets/images/slider2.jpg'),
                      CarouselItemWidget('assets/images/slider3.jpg')
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.easeInOutCubic,
                      enlargeCenterPage: true,
                    ),

                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) => BuildCategoryItem(cubit.categories[index]),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 30.0,),
                        itemCount: cubit.categories.length
                    ),
                  ),
                  state is HomePaginationLoadingState? const Center(child: CircularProgressIndicator(),):
                  const SizedBox.shrink(),
                ],
              ),
            );
          }
          return Container();
        },
        listener: (BuildContext context, HomeState state) {  },
      ),
    );
  }
}

//const