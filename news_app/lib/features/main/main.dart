import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/bloc_observer.dart';
import 'package:news_app/core/network/local/shared_preferences_helper.dart';
import 'package:news_app/core/styles/theme.dart';
import '../../core/network/remote/dio_helper.dart';
import '../home/presentations/ui/home_layout.dart';
import 'bloc/main_cubit.dart';
import 'bloc/main_states.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocProvider(
        create: (BuildContext context) => MainCubit()..getThemeMode(),
        child: BlocConsumer<MainCubit,MainState>(
          builder: (BuildContext context, MainState state){
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: MainCubit.get(context).theme,
                home: HomeLayout()
            );
          },
          listener: (BuildContext context, MainState state){},
        )
    );
  }
}