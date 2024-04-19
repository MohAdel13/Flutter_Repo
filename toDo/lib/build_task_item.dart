import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit.dart';
import 'package:todo/states.dart';

Widget buildTaskItem({required List list, required int index}){
  return BlocConsumer<AppCubit, AppStates>(
    builder: (BuildContext context, AppStates state) {
      AppCubit cubit = AppCubit.getInstance(context);
      return Dismissible(
        onDismissed: (direction)async{
          await cubit.deleteFromDatabase(list[index]['id']).then((value){
            cubit.afterDatabaseChange();
          });
        },
        key: Key(list[index]['id'].toString()),
        child: Container(
        padding:
          const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blueGrey,
                child: Text(list[index]['time'], style: const TextStyle(color: Colors.white),),
              ),
              const SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list[index]['title'], style: const TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
                    Text(list[index]['date'], style: const TextStyle(color: Colors.grey),)
                  ],
                ),
              ),
              const SizedBox(width: 20.0,),
              IconButton(
                  onPressed: (){
                      cubit.updateDatabase(status: "Done", id: list[index]['id']).then((value){
                      cubit.afterDatabaseChange();
                    });
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.green,)
              ),
              const SizedBox(width: 3.0,),
              IconButton(
                  onPressed: (){
                    cubit.updateDatabase(status: "Archived", id: list[index]['id']).then((value){
                      cubit.afterDatabaseChange();
                    });
                  },
                  icon: const Icon(Icons.archive_rounded, color: Colors.black54,)
              ),
            ],
          ),
        ),
      );
    },
    listener: (BuildContext context, AppStates state) {  },
  );
}