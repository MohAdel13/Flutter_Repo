import 'package:chatty/features/users/bloc/users_cubit.dart';
import 'package:chatty/features/users/bloc/users_states.dart';
import 'package:chatty/features/users/presentation/widgets/user_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit()..getUsers(),
      child: BlocConsumer<UsersCubit, UsersStates>(
        builder: (BuildContext context, UsersStates state) {
          UsersCubit cubit = UsersCubit.get(context);
          return ListView.separated(
              itemBuilder: (context, index) => UserItemWidget(user: cubit.users[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 20.0,),
              itemCount: cubit.users.length
          );
        },
        listener: (BuildContext context, UsersStates state) {  },
      ),
    );
  }
}
