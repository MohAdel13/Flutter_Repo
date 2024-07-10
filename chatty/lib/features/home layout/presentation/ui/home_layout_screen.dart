import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/features/add%20post/presentation/ui/add_post_screen.dart';
import 'package:chatty/features/home%20layout/bloc/home_layout_cubit.dart';
import 'package:chatty/features/home%20layout/bloc/home_layout_states.dart';
import 'package:chatty/features/home%20layout/presentation/widgets/custom_buttom_navigation_bar.dart';
import 'package:chatty/features/login/presentation/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        builder: (BuildContext context, HomeLayoutStates state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: (){},
                  icon: const FaIcon(FontAwesomeIcons.bell),
                ),
                IconButton(
                  onPressed: (){
                    CacheHelper.removeData('token');
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  },
                  icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
                )
              ],
            ),

            bottomNavigationBar: CustomButtomNavigationBar(
              onTap: (index){
                if(index == 2){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPostScreen())
                  );
                }
                else{
                  cubit.changeIndex(index);
                }
              },
              currentIndex: cubit.currentIndex,
            ),

            body: cubit.screens[cubit.currentIndex],
          );
        },
        listener: (BuildContext context, HomeLayoutStates state) {  },
      ),
    );
  }
}
