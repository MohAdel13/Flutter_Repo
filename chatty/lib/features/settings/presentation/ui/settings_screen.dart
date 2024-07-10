import 'package:chatty/features/edit%20profile/presentation/ui/edit_profile_screen.dart';
import 'package:chatty/features/settings/bloc/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../bloc/settings_states.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsCubit()..getUser(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        builder: (BuildContext context, SettingsStates state) {
          SettingsCubit cubit = SettingsCubit.get(context);

          if(state is SettingsLoadingState){
            EasyLoading.show();
            return Container(color: Colors.white,);
          }

          else if(state is SettingsErrorState){
            EasyLoading.showError('Error Happened');
            return Container(color: Colors.white,);
          }

          else{
            EasyLoading.dismiss();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 220.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  cubit.user.coverImage!
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                cubit.user.image!
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 5.0,),

                Text(cubit.user.name!, style: Theme.of(context).textTheme.headlineLarge,),

                const SizedBox(height: 20.0,),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('100', style: Theme.of(context).textTheme.headlineSmall,),
                          Text('Posts', style: Theme.of(context).textTheme.titleSmall,)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('10k', style: Theme.of(context).textTheme.headlineSmall,),
                          Text('Followers', style: Theme.of(context).textTheme.titleSmall,)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('20k', style: Theme.of(context).textTheme.headlineSmall,),
                          Text('Following', style: Theme.of(context).textTheme.titleSmall,)
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                OutlinedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider.value(
                            value: cubit,
                            child: EditProfileScreen(),
                          )
                        )
                      );
                    },
                    child: Text('Edit Profile', style: Theme.of(context).textTheme.headlineMedium,)
                )
              ],
            ),
          );
        },
        listener: (BuildContext context, SettingsStates state) {  },
      )
    );
  }
}
