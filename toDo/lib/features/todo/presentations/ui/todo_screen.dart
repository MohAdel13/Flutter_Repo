import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/main%20layout/bloc/main_cubit.dart';
import 'package:todo/features/main%20layout/bloc/main_states.dart';

import '../../bloc/todo_cubit.dart';
import '../../bloc/todo_states.dart';
import '../widgets/todo_build_task_item.dart';

class TodoScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
        builder: (BuildContext context, MainState mainState){
          MainCubit mainCubit = MainCubit.get(context);
          return BlocProvider(
            create: (BuildContext context)=> TodoCubit()..getTodoTasks(),
            child: BlocConsumer<TodoCubit, TodoState>(
              builder: (BuildContext context, TodoState state){
                TodoCubit cubit = TodoCubit.get(context);
                if(mainState is DatabaseInsertState){
                  cubit.getTodoTasks();
                }
                if(state is TodoInitState){
                  return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
                }
                else{
                  return ListView.separated(
                    itemBuilder: ((context, index) => TodoBuildTaskItem(index: index)),
                    separatorBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(color: Colors.grey,height: 1,)
                    )
                    ),
                    itemCount: cubit.todoData.length,
                    scrollDirection: Axis.vertical,
                  );
                }
              },
              listener: (BuildContext context, TodoState state) {},
            ),
          );
        },
        listener: (BuildContext context, MainState mainState){}
    );
  }
}