import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/build_task_item.dart';
import 'package:todo/cubit.dart';
import 'package:todo/states.dart';

class ArchivedScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state){
        AppCubit cubit = AppCubit.getInstance(context);
        return ListView.separated(
          itemBuilder: ((context, index) => buildTaskItem(list: cubit.archivedData, index: index)),
          separatorBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(color: Colors.grey,height: 1,)
          )
          ),
          itemCount: cubit.archivedData.length,
          scrollDirection: Axis.vertical,
        );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}