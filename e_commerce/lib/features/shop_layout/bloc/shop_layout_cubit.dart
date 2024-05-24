import 'package:e_commerce/features/home/presentation/ui/home_screen.dart';
import 'package:e_commerce/features/shop_layout/%20bloc/shop_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile/presentation/ui/profile_screen.dart';
import '../../shop/presentation/ui/shop_screen.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit(): super(ShopLayoutInitState());

  List screens = [
    HomeScreen(),
    ShopScreen(),
    null,
    null,
    ProfileScreen()
  ];

  int currentIndex = 0;

  static ShopLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int index){
  //unfortunately the used Fake API doesn't contain favourite and cart data...
  if(index!=2 && index!=3){
      currentIndex = index;
      emit(ShopLayoutChangeIndex());
    }
  }
}