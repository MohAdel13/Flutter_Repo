import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/search/presentation/ui/search_screen.dart';
import '../../../main/bloc/main_cubit.dart';
import '../../../main/bloc/main_states.dart';

class HomeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MainCubit, MainState>(
        builder: (BuildContext context, MainState state){
          MainCubit cubit = MainCubit.get(context);
          if(state is MainLoadingState){
            return const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(value: cubit,child: SearchScreen(),),
                      )
                    );
                  },
                  icon: const Icon(Icons.search, )
                ),
                IconButton(
                    onPressed: (){
                      cubit.changeThemeMode();
                    },
                    icon: cubit.isDark! ? const Icon(Icons.light_mode, ) : const Icon(Icons.dark_mode)
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.business,),
                  label: 'Business'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports,),
                    label: 'Sport'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science,),
                    label: 'Science'
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (int index){
                cubit.changeIndex(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
        listener: (BuildContext context, MainState state) {},
      );
  }

}