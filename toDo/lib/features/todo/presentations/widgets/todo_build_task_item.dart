import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todo_cubit.dart';
import '../../bloc/todo_states.dart';


class TodoBuildTaskItem extends StatelessWidget {
  const TodoBuildTaskItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      builder: (BuildContext context, TodoState state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Dismissible(
          onDismissed: (direction)async{
            await cubit.deleteFromTodo(cubit.todoData[index]['id']);
          },
          key: Key(cubit.todoData[index]['id'].toString()),
          child: Container(
            padding:
            const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.blueGrey,
                  child: Text(cubit.todoData[index]['time'], style: const TextStyle(color: Colors.white),),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.todoData[index]['title'], style: const TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
                      Text(cubit.todoData[index]['date'], style: const TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
                const SizedBox(width: 20.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInTodo(status: "Done", id: cubit.todoData[index]['id']);
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.grey,)
                ),
                const SizedBox(width: 3.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInTodo(status: "Archived", id: cubit.todoData[index]['id']);
                    },
                    icon: const Icon(Icons.archive_rounded, color: Colors.grey,)
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, TodoState state) {  },
    );
  }
}
