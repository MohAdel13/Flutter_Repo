import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/archived/presentations/widgets/archived_build_task_item.dart';
import 'package:todo/features/archived/bloc/archived_cubit.dart';
import 'package:todo/features/archived/bloc/archived_states.dart';

class ArchivedScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ArchivedCubit()..getArchivedTasks(),
      child: BlocConsumer<ArchivedCubit, ArchivedState>(
        builder: (BuildContext context, ArchivedState state){
          ArchivedCubit cubit = ArchivedCubit.get(context);
          if(state is ArchivedInitState){
            return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          else{
            return ListView.separated(
              itemBuilder: ((context, index) => ArchivedBuildTaskItem(index: index)),
              separatorBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(color: Colors.grey,height: 1,)
              )
              ),
              itemCount: cubit.archivedData.length,
              scrollDirection: Axis.vertical,
            );
          }
        },
        listener: (BuildContext context, ArchivedState state) {},
      ),
    );
  }
}