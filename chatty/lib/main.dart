import 'package:bloc/bloc.dart';
import 'package:chatty/bloc_observer.dart';
import 'package:chatty/core/network/local/cache_helper.dart';
import 'package:chatty/core/style/themes.dart';
import 'package:chatty/features/home%20layout/presentation/ui/home_layout_screen.dart';
import 'package:chatty/features/login/presentation/ui/login_screen.dart';
import 'package:chatty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await CacheHelper.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    bool registeredUser = CacheHelper.sharedPreferences.containsKey('token');
    return MaterialApp(
      home: registeredUser? HomeLayoutScreen(): LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: lightTheme,
      builder: EasyLoading.init(),
    );
  }
}