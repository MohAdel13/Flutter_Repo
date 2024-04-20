import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/archived/bloc/archived_cubit.dart';
import 'package:todo/features/archived/bloc/archived_states.dart';

class ArchivedBuildTaskItem extends StatelessWidget {
  const ArchivedBuildTaskItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArchivedCubit, ArchivedState>(
      builder: (BuildContext context, ArchivedState state) {
        ArchivedCubit cubit = ArchivedCubit.get(context);
        return Dismissible(
          onDismissed: (direction)async{
            await cubit.deleteFromArchived(cubit.archivedData[index]['id']);
          },
          key: Key(cubit.archivedData[index]['id'].toString()),
          child: Container(
            padding:
            const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.blueGrey,
                  child: Text(cubit.archivedData[index]['time'], style: const TextStyle(color: Colors.white),),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.archivedData[index]['title'], style: const TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
                      Text(cubit.archivedData[index]['date'], style: const TextStyle(color: Colors.grey),)
                    ],
                  ),
                ),
                const SizedBox(width: 20.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInArchived(status: "Done", id: cubit.archivedData[index]['id']);
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.grey,)
                ),
                const SizedBox(width: 3.0,),
                IconButton(
                    onPressed: (){
                      cubit.updateInArchived(status: "New", id: cubit.archivedData[index]['id']);
                    },
                    icon: const Icon(Icons.archive_rounded, color: Colors.black,)
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, ArchivedState state) {  },
    );
  }
}
