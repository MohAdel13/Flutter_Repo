import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/done_cubit.dart';
import '../../bloc/done_states.dart';
import '../widgets/done_build_task_item.dart';

class DoneScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> DoneCubit()..getDoneTasks(),
      child: BlocConsumer<DoneCubit, DoneState>(
        builder: (BuildContext context, DoneState state){
          DoneCubit cubit = DoneCubit.get(context);
          if(state is DoneInitState){
            return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          else{
            return ListView.separated(
              itemBuilder: ((context, index) => DoneBuildTaskItem(index: index)),
              separatorBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(color: Colors.grey,height: 1,)
              )
              ),
              itemCount: cubit.doneData.length,
              scrollDirection: Axis.vertical,
            );
          }
        },
        listener: (BuildContext context, DoneState state) {},
      ),
    );
  }
}