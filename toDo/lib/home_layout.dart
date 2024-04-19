import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit.dart';
import 'package:todo/new_task_screen.dart';
import 'package:todo/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.getInstance(context);
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
                onPressed: () async{
                  bool inserted = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewTaskScreen(cubit: cubit,)),
                  );
                  if (inserted == true){
                    cubit.afterDatabaseChange();
                  }
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
          }),
    );
  }
}
