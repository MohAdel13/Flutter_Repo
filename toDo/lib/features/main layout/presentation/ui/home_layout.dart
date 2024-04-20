import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/main%20layout/bloc/main_cubit.dart';
import 'package:todo/features/new%20task/presentations/ui/new_task_screen.dart';
import 'package:todo/features/main%20layout/bloc/main_states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..createDatabase(),
      child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {},
          builder: (BuildContext context, MainState state) {
            MainCubit cubit = MainCubit.get(context);
            if(state is MainInitState){
              return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
            }

            else{
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlocProvider.value(value: cubit,
                          child: NewTaskScreen())),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  onTap: (id) {
                    cubit.changeIndex(id);
                    // setState(() {
                    //   cubit.currentIndex = id;
                    // });
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu), label: 'Todo'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive), label: 'Archived'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done_all), label: 'Done'),
                  ],
                ),
                body: cubit.screens[cubit.currentIndex],
              );
            }
          }),
    );
  }
}
