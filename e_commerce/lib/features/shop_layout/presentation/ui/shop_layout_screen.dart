import 'package:e_commerce/features/shop_layout/%20bloc/shop_layout_cubit.dart';
import 'package:e_commerce/features/shop_layout/%20bloc/shop_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLayoutCubit(),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        builder: (BuildContext context, ShopLayoutStates state){
          ShopLayoutCubit cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/home.png'),
                  label: 'Home',
                  activeIcon: Image.asset('assets/images/home_selected.png'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/shop.png'),
                  label: 'Shop',
                  activeIcon: Image.asset('assets/images/shop_selected.png'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/favourite.png'),
                  label: 'Favourite',
                  activeIcon: Image.asset('assets/images/favourite_selected.png'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/cart.png'),
                  label: 'Cart',
                  activeIcon: Image.asset('assets/images/cart_selected.png'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/profile.png'),
                  label: 'Profile',
                  activeIcon: Image.asset('assets/images/profile_selected.png'),
                ),
              ],
              onTap: (int index){cubit.changeIndex(index);},
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
        listener: (BuildContext context, ShopLayoutStates state) {  },
      ),
    );
  }
}
