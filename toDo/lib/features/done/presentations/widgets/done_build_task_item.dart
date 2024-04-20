import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/done_cubit.dart';
import '../../bloc/done_states.dart';

class DoneBuildTaskItem extends StatelessWidget {
  const DoneBuildTaskItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoneCubit, DoneState>(
      builder: (BuildContext context, DoneState state) {
        DoneCubit cubit = DoneCubit.get(context);
        return Dismissible(
          onDismissed: (direction)async{
            await cubit.deleteFromDone(cubit.doneData[index]['id']);
          },
          key: Key(cubit.doneData[index]['id'].toString()),
          child: Container(
            padding:
            const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.blueGrey,
                  child: Text(cubit.doneData[index]['time'], style: const TextStyle(color: Colors.white),),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.doneData[index]['title'], style: const TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
                      Text(cubit.doneData[index]['date'], style: const TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
                const SizedBox(width: 20.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInDone(status: "New", id: cubit.doneData[index]['id']);
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.green,)
                ),
                const SizedBox(width: 3.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInDone(status: "Archived", id: cubit.doneData[index]['id']);
                    },
                    icon: const Icon(Icons.archive_rounded, color: Colors.grey,)
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, DoneState state) {  },
    );
  }
}
